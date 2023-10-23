 
 
 
 variable "cloudflare_zone_id" {}


 module "acm" {
     source = "../modules/acm"
     domain_name = "*.aws.vinny.dev.br"
     cloudflare_zone_id = var.cloudflare_zone_id
}