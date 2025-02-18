module "vpc" {
    source="./vpc"
    vpc_cidr="10.0.0.0/16"
    pub_subnet1_cidr="10.0.1.0/24"
    pub_subnet2_cidr="10.0.2.0/24"
    pri_subnet1_cidr = "10.0.3.0/24"
    pri_subnet2_cidr = "10.0.4.0/24"
  
}

module "compute" {
    source="./compute"
    image_id="ami-039454f12c36e7620"
    instance_type="t2.micro"
    web_sg_id=module.vpc.web_sg_id
    lb_sg_id=module.vpc.lb_sg_id
    vpc_id=module.vpc.ass10_vpc_id
    pub_subnet1_id=module.vpc.pub_subnet1_id
    pub_subnet2_id=module.vpc.pub_subnet2_id
    pri_subnet1_id=module.vpc.pri_subnet1_id
    pri_subnet2_id=module.vpc.pri_subnet2_id
}

module "data" {
  source = "./data"
  dbsubnet1 = module.vpc.pri_subnet1_id
  dbsubnet2 = module.vpc.pri_subnet2_id
  db_sg_id = module.vpc.db_sg_id
}

