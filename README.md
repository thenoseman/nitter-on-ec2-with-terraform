# nitter instance on AWS EC2

This terraform setup creates a [nitter deployment](https://github.com/zedeus/nitter) on a simple EC2 instance behind a network load balancer.

```
┌────────────────────┐
│  network load      │
│  balancer    (FQDN)│
└─────────┬──────────┘
          │port 8080  
┌─────────▼──────────┐
│ autoscaling group  │
│  ┌──────────────┐  │
│  │ EC2 Instance │  │
│  │              │  │
│  │   "nitter"   │  │
│  └──────────────┘  │
│                    │
└────────────────────┘
```



## Usage

You can configure the instance type and the username later needed to access the nitter instance.
See `basic_auth_username` and `instance_type`  in `variables.tf`.

The following is copied from [sekai-soft/guide-nitter-self-hosting](https://github.com/sekai-soft/guide-nitter-self-hosting/blob/master/docs/i-only-want-a-nitter-instance.md):

1. Create a throw away twitter account ([here](https://twitter.com/i/flow/signup)) **without MFA enabled**.

2. After that you will need actual nitter auth. In this directory execute:

   ```sh
   git clone --depth 1 https://github.com/sekai-soft/guide-nitter-self-hosting 
   cd guide-nitter-self-hosting
   docker compose run --build nitter-auth
   ```

3. Execute the last "echo" line as advised. The authentication will be read by the terraform setup.

4. To set variables create `variables.auto.tfvars` and fill `basic_auth_username` and/or `instance_type`.

5. Do the usual `terraform init` and `terraform apply` you will get the following output:

```
basic-auth-password = "some-basic-authpassword"
basic-auth-username = "nitter"
lib-redirect-twitter-url = <<EOT
USAGE WITH LIB-REDIRECT CHROME EXTENSION:
-----------------------------------------
Install https://libredirect.github.io/download.html
Open the options of the extension and select "Twitter" on the left side.
Click on the input field under "Add own instance" and enter:

http://nitter:some-basic-authpassword@nitter-123456789.elb.eu-central-1.amazonaws.com:8080

EOT
```

You can now access your private nitter instance as http://nitter:some-basic-authpassword@nitter-123456789.elb.eu-central-1.amazonaws.com:8080
