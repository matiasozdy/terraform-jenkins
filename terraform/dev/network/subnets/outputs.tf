output "public_subnet" {
 value = ["${aws_subnet.public.*.id}"]
}

output "dmz_subnet" {
 value = ["${aws_subnet.dmz.*.id}"]
}

output "app_subnet" {
 value = ["${aws_subnet.app.*.id}"]
}

output "db_subnet" {
 value = ["${aws_subnet.db.*.id}"]
}
