

module "ecs" {
  source = "../modules/ecs"
  vpc_id = data.aws_vpc.redezinha.id
  subnets =  data.aws_subnets.redezinha_subnet.ids
  docker_image = "nginx"
  security_group = data.aws_security_groups.security_groupzinho.ids
  acm_certificate = data.aws_acm_certificate.domain.arn
  elb_target_group_arn =  data.aws_lb_target_group.lb_target_group.arn
}


