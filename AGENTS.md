# AGENTS.md — Terraform Repository Guide

This is an AWS infrastructure-as-code repository using Terraform. Use this guide when
working with any `.tf` files or Terraform commands in this repo.

## Environment

- **Provider:** AWS, region `ap-southeast-1`, configured with named profile `personal` (`provider.tf`).
- **State:** No remote backend is configured; state is local (`.tfstate`, which is git-ignored).
- **Lock file:** `.terraform.lock.hcl` pins provider versions — commit it.

## Repository structure

Root `main.tf` wires together three local modules via `source = "./<module>"`:

- `vpc/` — VPC, subnets (2 public, 2 private), internet/nat gateways, route tables, and security groups (`web_sg`, `lb_sg`, `db_sg`).
- `compute/` — Launch template, Auto Scaling Group, Application Load Balancer, target group, and SSM IAM role.
- `data/` — RDS database instance and its outputs.

Each module follows the same internal layout:
- `variable.tf` — input variables (most are `type = string`).
- `output.tf` — exported values consumed by other modules (e.g. subnet IDs, security group IDs, VPC ID).
- One or more resource files (e.g. `vpc.tf`, `subnet.tf`, `sg.tf`, `rds.tf`).

## Conventions to follow

- **Resource naming:** Prefix local resources with `ass10_` (e.g. `aws_vpc.ass10_vpc`, `aws_subnet.ass10_pub_subnet1`). Match existing names when adding related resources.
- **Module interface:** Pass values between modules through `module.<name>.output_name` references in the root `main.tf`, not by duplicating values.
- **File organization:** Put new variables in `variable.tf`, outputs in `output.tf`, and resources in the most relevant existing resource file (or a new clearly-named `.tf` file).
- **Variable style:** Existing variables are untyped-default `string` with inconsistent spacing; keep additions consistent with the surrounding file.
- **No secrets in code:** `.tfvars` files and `*.tfstate` are git-ignored for a reason. Prefer `sensitive = true` on secret variables. **Note:** `db_password` is currently hard-coded in `main.tf` — move it to a `.tfvars` file or a secret store rather than committing it.

## Common commands

Run these from the module or repo root after `cd`-ing via the Bash tool's `workdir`:

- `terraform init` — initialize providers/modules (run after adding new modules or providers).
- `terraform fmt` — format all `.tf` files (keep code formatted before committing).
- `terraform validate` — validate configuration syntax and internal consistency.
- `terraform plan` — preview changes (uses the `personal` AWS profile).
- `terraform apply` — apply changes.

## Working safely

- Always run `terraform fmt` and `terraform validate` after editing `.tf` files.
- Run `terraform plan` before any `apply` and review the diff, especially for the `data`/RDS and `compute`/ASG resources which can be costly or destructive.
- Never commit `.tfstate`, `.tfvars`, or override files; they are intentionally git-ignored.
