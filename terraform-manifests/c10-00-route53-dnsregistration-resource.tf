# DNS Registration 
resource "aws_route53_record" "apps_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id 
  name    = "asg-lt.landcot.com"
  type    = "A"

  # The alias points the above created DNS directly to my Application Load Balancer.
  alias {
    name                   = module.alb.dns_name    # When someone visits asg-lt.landcot.com, silently redirect them to this long ALB address.
    zone_id                = module.alb.zone_id
    evaluate_target_health = true   # Route 53 will check if your Load Balancer is healthy.
  }  
}