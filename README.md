# Important

## Usage

```hcl
module "my-hab-instance" {
  source                     = "devoptimist/hab-instance/windows"
  version                    = "0.0.1"
  ami                        = "ami-1234"
  instance_count             = "5"
  vpc_security_group_ids     = ["sg-1234"]
  subnet_ids                 = ["sn-12234"]
  admin_pass                 = "P@55w0rd1"
}
```
## Inputs

| Name | Description | Type | Default | Required |
|ami|An ami id to create the instances from|string|no|yes|
