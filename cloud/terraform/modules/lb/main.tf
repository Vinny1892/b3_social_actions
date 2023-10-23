terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
       version = "4.16.0"
    }
  }
}

variable "subnets" {
  
}

variable "security_group" {
  
}

variable "vpc_id" {
  
}

variable "acm_certificate" {
  
}

variable "cloudflare_zone_id" {
  
}
variable "dns_app" {
  
}

resource "aws_lb" "example_elb" {
  name               = "example-elb"
  subnets = var.subnets
  security_groups    = var.security_group
  load_balancer_type = "application"

}


resource "aws_lb_target_group" "example_target_group" {
  name     = "seila"
  port     = 80
  protocol = "HTTP"
  vpc_id   =  var.vpc_id  # Substitua pelo ID da sua VPC
  target_type = "ip"
}

resource "aws_lb_listener" "example_listener" {
  load_balancer_arn = aws_lb.example_elb.id
  port              = 443
  protocol          = "HTTPS"
  certificate_arn = var.acm_certificate

   default_action {
     type             = "forward"
     target_group_arn = aws_lb_target_group.example_target_group.arn
   }

}


resource "aws_lb_listener" "redirect" {
  load_balancer_arn = aws_lb.example_elb.id
  port              = 80
  protocol          = "HTTP"

   default_action {
     type             = "redirect"
      redirect {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }   
  }

}

resource "cloudflare_record" "example" {
  
  zone_id = var.cloudflare_zone_id
  name    = var.dns_app
  value   =  aws_lb.example_elb.dns_name
  type    =  "CNAME"
  ttl     = 3600
}


output "elb_dns_name" {
  value = aws_lb.example_elb.dns_name
}
