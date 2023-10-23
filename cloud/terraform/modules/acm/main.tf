terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
       version = "4.16.0"
    }
  }
}

variable "domain_name" {
  default = "*.aws.vinny.dev.br"
}

variable "cloudflare_zone_id" {
  
}

resource "aws_acm_certificate" "certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"
}


resource "cloudflare_record" "example" {

      for_each = {
        for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
          name   = dvo.resource_record_name
          record = dvo.resource_record_value
          type   = dvo.resource_record_type
        }
    }
 
    zone_id = var.cloudflare_zone_id
    name    = each.value.name
    value   =  each.value.record
    type    =  each.value.type
    ttl     = 3600
}
