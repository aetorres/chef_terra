# AWS DevOps engineer evaluation

The README.md from the test in on ```chef/tomcat_test/README.md```


## Objective

Evalueate your knowledge/experience in three key areas: AWS, Chef and Terraform.

## Asumptions

We assume that you have a working AWS account where you can test the infrastructure you're developing. If you don't have a personal account, you can create one and make use of the [AWS free tier](https://aws.amazon.com/free/).

## Topics

- AWS.
- Chef.
- Infrastructure as code (terraform).

## Details

### The application

We require you to install a Java application on top of Tomcat. It can be any application, but we suggest 
using [this sample](https://tomcat.apache.org/tomcat-6.0-doc/appdev/sample/). To do that, you have to create
a Chef cookbook, and then use it from Terraform.

### Chef

Create a chef (wrapper) cookbook to install and configure Tomcat and its requirements (you can use any comunity cookbooks - only from the Chef supermarket). You must also include tests for your cookbook (using test kitchen + serverspec). Additionally, your cookbook must pass food critic and rubocop.

### Terraform

#### AWS Resources

You'll need to create (at least) the following resources:
- A VPC.
- One or more subnets (depending on your design).
- One or more security groups (depending on your design).
- One ELB.

The following diagram can give you a better idea of what you should code in terraform:

```
                        .───────.                  
                      ,'         `.                
                     ;             :               
                     :   ┌─────┐   ;               
                      ╲  │Users│  ╱                
                       `.└─────┘,'                 
                         `──┬──'                   
                            │                      
                            │                      
    ┌─┬────┬────────────────┼─────────────────────┐
    │ │AWS │                │                     │
    │ └────┘                │                     │
    │     ┌─┬────┬──────────▼──────────────────┐  │
    │     │ │VPC │   ┌──────────┐TCP           │  │
    │     │ └────┘   │  ┌────┐  │80            │  │
    │     │          │  │ELB │  │              │  │
    │     │          └──┴────┴──┘              │  │
    │     │                │                   │  │
    │     │                │                   │  │
    │     │                │                   │  │
    │     │         ┌──────▼───────┐TCP        │  │
    │     │         │┌────────────┐│8080       │  │
    │     │         ││EC2 Instance││           │  │
    │     │         └┴────────────┴┘           │  │
    │     └────────────────────────────────────┘  │
    │                                             │
    └─────────────────────────────────────────────┘
```              

## Deliverables

### Instructions

You must provide instructions to reproduce your infrastructure, it can be a regular README file. You have to provide instructions to test your cookbook.

### Code

You have to ship your code to us, please create a pull request against the upstream repo.

