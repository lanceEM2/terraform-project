# Autoscaling Group Resource
resource "aws_autoscaling_group" "my_asg" {
  name_prefix = "${local.name}-"
  desired_capacity = 2
  max_size = 10
  min_size = 2
  vpc_zone_identifier = module.vpc.private_subnets
  
  target_group_arns = [module.alb.target_groups["mytg1"].arn]
  
  health_check_type = "EC2"
  #health_check_grace_period = 300 # default is 300 seconds
  launch_template {
    id = aws_launch_template.my_launch_template.id 
    version = aws_launch_template.my_launch_template.latest_version
  }
  # Instance Refresh
  instance_refresh {
    strategy = "Rolling"    # It will kill a few, wait for new ones to become healthy, and then move on to the next batch.
    preferences {
      min_healthy_percentage = 50   # It must keep at least 50% (1 instance, since desired capacity is 2) healthy and running at all times so your users don't experience a total outage.        
    }
    triggers = [ "desired_capacity" ] # Usually, people use triggers = ["launch_template"] so that when the AMI or User Data changes, the servers update.
  }
  tag {
    key                 = "Owners"
    value               = "Web-Team"
    propagate_at_launch = true
  }
}