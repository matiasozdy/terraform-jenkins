# Building an entire infra with terraform and automating with jenkins 2.0

## Installation
#### Prequisites:
Get terraform binary: wget https://releases.hashicorp.com/terraform/0.9.8/terraform_0.9.8_linux_amd64.zip
Install docker: apt-get install docker.io

Run jenkins with the provided run.sh on the jenkins folder.

Generate corresponding buckets in your aws account

## Defining the infrastructure
I've used separated tfstates for each terraform project on a bucket per environment, it's something I don't agree 100%  but it works quite right for now.
In the tools folder there are some scripts to generate the environment based on the defined modules.

## Structure

- terraform
    - modules
        - core
            - nginx
    - ops
            - Some ops service
    - product
            - Some product service
    - environments (Dev)
            - common-services
                - cache
                - databases
            - filesystems
            - network
                - acl
                - balancers
                - inetgw
                - secgroups
                - subnets
                - vpc
    - tools


## Usage
