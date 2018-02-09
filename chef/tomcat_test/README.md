# Tomcat Test

#Pre-requisites

* GIT
* Ruby
* Chef
* Terraform
* AWS account 
* Bash console


#Creation Steps

* Check the profile name used for AWS you could change it for your own or
create one in <a href="https://console.aws.amazon.com/iam/home?region=us-west-2#/users"/>AWS IAM</a>
* Execute ```terraform init``` to initialize terraform
* Execute ```terraform plan``` for check the objects that will be created
* Execute ```terraform apply``` then wait for the execution
* Go to your AWS Dashboard and look for your new ELB, copy your DNS name and attach at the end ```/sample```
* And there you go! your Tomcat server running.

# More Information?

* My [mail](mailto:andres.torresduran@gmail.com)
* My [GitLab account](https://gitlab.com/aetorres)
* My [Bitbucket account](https://bitbucket.org/aetorres/)
* My [GitLab account](https://github.com/aetorres)
* My [Twitter](https://twitter.com/Andr3s_T)
