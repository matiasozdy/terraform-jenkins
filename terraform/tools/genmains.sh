#!/bin/bash
#Copy this to your tf root where you have the modules folder and edit environment. 
env="dev"
#env=${env,,}
env2="Dev"
for a in core ops product; do
	for b in modules/$a/*/; do
		echo "Path:" $b;
		echo "Name: $(basename $b)"
		basen=$(basename $b)
		count=0
		mkdir -p $env/services/$a/$basen
		echo 'module "'$basen'" { ' > $env/services/$a/$basen/main.tf
		echo '    source = "../../../../modules/'$a'/'$basen'" ' >> $env/services/$a/$basen/main.tf
		for c in `cat $b/variables.tf | grep variable | cut -f2 -d" " | sed 's/^"\(.*\)".*/\1/'`; do
			count=$((count+1))
			#If there are global variables, hardcode them here :)
			echo "Variable $count: $c"
			if [ "$c" == "azs" ]; then
				echo '    '$c' = ["us-east-1a", "us-east-1b", "us-east-1c"]' >> $env/services/$a/$basen/main.tf	
			elif [ "$c" == "config_key" ]; then
				echo '    '$c' = "MYKEY"' >> $env/services/$a/$basen/main.tf
			elif [ "$c" == "region" ]; then	
				echo '    '$c' = "us-east-1"' >> $env/services/$a/$basen/main.tf	
			elif [ "$c" == "subnet" ]; then	
				echo '    '$c' = ["${data.terraform_remote_state.remote_'$env'_subnets.app_subnet}"]' >> $env/services/$a/$basen/main.tf	
			elif [ "$c" == "env" ]; then	
				echo '    '$c' = "'$env2'"' >> $env/services/$a/$basen/main.tf
			else
				echo '    '$c' = ""' >> $env/services/$a/$basen/main.tf
			fi

		done
		echo '}' >> $env/services/$a/$basen/main.tf
		echo 'terraform {
  backend "s3" {
    bucket = "terraform-sb-st-'$env'"
    key = "'$env'-'$a'-'$basen'-terraform.tfstate"
    encrypt = "true"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "remote_'$env'_vpc" {
  backend = "s3"
  config {
     bucket="terraform-sb-st-'$env'"
     key="'$env'-vpc-terraform.tfstate"
     region = "us-east-1"
  }
}

data "terraform_remote_state" "remote_'$env'_subnets" {
  backend = "s3"
  config {
     bucket="terraform-sb-st-'$env'"
     key="'$env'-subnets-terraform.tfstate"
     region = "us-east-1"
  }
}

data "terraform_remote_state" "remote_'$env'_secgroups" {
  backend = "s3"
  config {
     bucket="terraform-sb-st-'$env'"
     key="'$env'-secgroups-terraform.tfstate"
     region = "us-east-1"
  }
}' > $env/services/$a/$basen/variables-g.tf
	done
done
