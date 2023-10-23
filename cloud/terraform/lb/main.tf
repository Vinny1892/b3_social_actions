variable "cloudflare_zone_id" {}

 module "lb" {
    source = "../modules/lb"
    vpc_id = data.aws_vpc.redezinha.id
    subnets =  data.aws_subnets.redezinha_subnet.ids
    dns_app =  "app.aws.vinny.dev.br"
    security_group = data.aws_security_groups.security_groupzinho.ids
    acm_certificate = data.aws_acm_certificate.domain.arn
    cloudflare_zone_id = var.cloudflare_zone_id
   
 }