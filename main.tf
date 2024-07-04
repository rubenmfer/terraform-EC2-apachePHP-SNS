module "sns" {
    source  = "./modules/sns"
    sns_topic_name = "formulario"
    email   = "ruben.martinezfernandez@tajamar365.com"
}

module "compute" {
    source          = "./modules/compute"
    ami             = "ami-01b799c439fd5516a"
    instance_type   = "t2.micro"
    key_name        = "vockey"
    ssh_user        = "ec2-user"
    ssh_fname       = "ssh.pem"
    script          = "install_apache.sh"
    sns_topic_arn   = module.sns.sns_topic_arn
}