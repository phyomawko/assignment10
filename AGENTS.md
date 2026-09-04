# AGENTS.md

## 1. Module Directory Structure

### 1.1 Overview

```
.
├── main.tf
├── variables.tf
├── data.tf
├── providers.tf
├── terraform.tf
└── modules/
    ├── vpc/
    │   ├── main.tf
    │   ├── data.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── alb/
        ├── main.tf
        ├── data.tf
        ├── variables.tf
        └── outputs.tf
```

Root wires modules together. No resources in root `main.tf`, only `module` blocks.

### 1.2 Module Details

#### `modules/vpc`

- `main.tf`:
  - `aws_vpc.this`
  - `aws_subnet.public_subnets` (count over `var.public_subnet_cidrs`)
  - `aws_subnet.private_subnets` (count over `var.private_subnet_cidrs`)
  - `aws_subnet.isolated_subnets` (count over `var.isolated_subnet_cidrs`)
  - `aws_internet_gateway.this`
  - `aws_eip.this`
  - `aws_nat_gateway.this` (in `public_subnets[0]`)
- `data.tf`:
  - `data.aws_availability_zones.this`
- `variables.tf`: `cidr_block`, `vpc_name`, `public_subnet_cidrs`, `private_subnet_cidrs`, `isolated_subnet_cidrs`, `azs`
- `outputs.tf`: `vpc_id`, `vpc_cidr_block`, `public_subnet_ids`, `private_subnet_ids`, `isolated_subnet_ids`, `internet_gateway_id`, `nat_gateway_id`

#### `modules/alb`

- `main.tf`:
  - `aws_security_group.this`
  - `aws_vpc_security_group_ingress_rule.http` (for_each `var.ingress_cidr_blocks`)
  - `aws_vpc_security_group_ingress_rule.https` (for_each `var.ingress_cidr_blocks`)
  - `aws_vpc_security_group_egress_rule.all`
  - `aws_lb.this`
  - `aws_lb_target_group.this`
  - `aws_lb_listener.https` (forward to target group)
  - `aws_lb_listener.http` (redirect to HTTPS 301)
- `data.tf`: none required currently; file must still exist (empty or with future data sources)
- `variables.tf`: `name`, `vpc_id`, `subnet_ids`, `certificate_arn`, plus optionals `internal`, `enable_deletion_protection`, `idle_timeout`, `enable_http2`, `http_port`, `https_port`, `ssl_policy`, `target_group_port`, `target_group_protocol`, `target_type`, `deregistration_delay`, `health_check_*`, `healthy_threshold`, `unhealthy_threshold`, `ingress_cidr_blocks`, `tags`
- `outputs.tf`: `alb_arn`, `alb_arn_suffix`, `alb_dns_name`, `alb_zone_id`, `alb_security_group_id`, `target_group_arn`, `target_group_arn_suffix`, `target_group_name`, `https_listener_arn`, `http_listener_arn`

Root module inputs (`variables.tf`): `region`, `cidr_block`, `vpc_name`, `public_subnet_cidrs`, `private_subnet_cidrs`, `isolated_subnet_cidrs`, `azs`, `alb_name`, `certificate_arn`.

## 2. Workflow

Run from repo root. Requires Terraform `1.15.8` and AWS provider `6.58.0` per `terraform.tf` / lock file.

```sh
terraform init
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

Order is mandatory: `init` -> `fmt` -> `validate` -> `plan` -> `apply`. Do not skip `validate` or `fmt`. Do not run `apply` without a prior `plan` file.

## 3. Convention Rules

1. Singleton resource label: if only one resource of a given type exists in a module, its label must be `this`.
   - Correct: `resource "aws_vpc" "this"`, `resource "aws_internet_gateway" "this"`, `resource "aws_nat_gateway" "this"`, `resource "aws_lb" "this"`, `resource "aws_security_group" "this"`.
   - Multiple instances of same type use plural/descriptive labels: `aws_subnet.public_subnets`, `aws_subnet.private_subnets`, `aws_subnet.isolated_subnets`, `aws_lb_listener.http` / `aws_lb_listener.https`.
2. File separation per module (exactly these 4 files, no additional `.tf` files):
   - `main.tf`: only `resource` blocks.
   - `data.tf`: only `data` blocks.
   - `variables.tf`: only `variable` blocks.
   - `outputs.tf`: only `output` blocks.
3. Do not add new `.tf` files inside `modules/*`. Do not put `data`/`variable`/`output` blocks in `main.tf` and do not put `resource` blocks elsewhere.

## 4. Violation

- Never run `git commit`, `git commit -am`, or any commit variant yourself. Never amend, bypass hooks, or push commits unless explicitly asked.
