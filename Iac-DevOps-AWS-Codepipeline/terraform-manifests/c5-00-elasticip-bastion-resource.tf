# Create Elastic IP for Bastion Host
# Since the Bastion is your primary "door" into the private network, that door needs to stay in the same place.
# Resource - depends_on Meta-Argument
resource "aws_eip" "bastion_eip" {
  tags = local.common_tags
  instance = module.ec2_public.id
  domain = "vpc"  # Indicates if this EIP is for use in VPC
}