# Create Elastic IP for Bastion Host
# Since the Bastion is your primary "door" into the private network, that door needs to stay in the same place.
# Resource - depends_on Meta-Argument
resource "aws_eip" "bastion_eip" {
  tags = local.common_tags

  # UPDATED
  instance = module.ec2_public.id
  domain = "vpc"  # Indicates if this EIP is for use in VPC

## Local Exec Provisioner:  local-exec provisioner (Destroy-Time Provisioner - Triggered during deletion of this Resource)
  provisioner "local-exec" {
    command = "echo Destroy time prov `date` >> destroy-time-prov.txt"
    working_dir = "local-exec-output-files/"
    when = destroy
    #on_failure = continue
  }  
}