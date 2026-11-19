# Static Website Hosting on Amazon S3 using Terraform

This project demonstrates how to host a static website on Amazon S3 using Terraform for Infrastructure as Code.

## 📋 Project Overview

This is a complete Infrastructure as Code solution that:
- Creates an S3 bucket configured for static website hosting
- Uploads HTML and CSS files to the bucket
- Configures public read access via bucket policies
- Provides website endpoint output

## 🏗️ Architecture

```
┌─────────────────────────────────┐
│   S3 Bucket (Website Hosting)   │
│  ├── index.html                 │
│  └── styles.css                 │
├─────────────────────────────────┤
│   Website Configuration         │
├─────────────────────────────────┤
│   Public Access Policy          │
├─────────────────────────────────┤
│   Public Access Block           │
└─────────────────────────────────┘
```

## 📁 Project Structure

```
.
├── main.tf              # Main Terraform configuration
├── variables.tf         # Input variables
├── outputs.tf           # Output values
├── index.html          # Website homepage
├── styles.css          # Website styling
├── .gitignore          # Git ignore rules
└── README.md           # This file
```

## 🚀 Prerequisites

Before you start, ensure you have:

1. **Terraform** installed (v1.0+)
   - Download: https://www.terraform.io/downloads.html

2. **AWS Account** with:
   - Access key ID
   - Secret access key
   - Appropriate IAM permissions for S3

3. **AWS CLI** configured (optional but recommended)
   ```bash
   aws configure
   ```

4. **Git** for version control

## 📝 Configuration

### Variables

You can customize the deployment by modifying `variables.tf`:

- `aws_region`: AWS region (default: us-east-1)
- `bucket_name`: S3 bucket name (must be globally unique)
- `environment`: Environment name (default: production)

### Update Bucket Name

⚠️ **Important**: S3 bucket names must be globally unique across all AWS accounts.

Edit `variables.tf` and change the `bucket_name` default value:

```hcl
variable "bucket_name" {
  default = "my-unique-bucket-name-your-name-2024"
}
```

## 🛠️ Deployment Steps

### Step 1: Initialize Terraform

Navigate to the project directory and initialize Terraform:

```bash
cd P2-Host-Static-Website
terraform init
```

This command:
- Downloads the AWS provider
- Creates `.terraform` directory
- Generates `.terraform.lock.hcl`

### Step 2: Review the Plan

Preview the resources that will be created:

```bash
terraform plan
```

This shows all AWS resources that Terraform will create without making any changes.

### Step 3: Apply Configuration

Create the AWS resources:

```bash
terraform apply
```

Type `yes` when prompted to confirm.

**Output Example:**
```
Apply complete! Resources: 6 added, 0 changed, 0 destroyed.

Outputs:
bucket_name = "my-static-website-rahul-kujur-2024"
bucket_arn = "arn:aws:s3:::my-static-website-rahul-kujur-2024"
website_endpoint = "my-static-website-rahul-kujur-2024.s3-website-us-east-1.amazonaws.com"
website_domain = "http://my-static-website-rahul-kujur-2024.s3-website-us-east-1.amazonaws.com"
```

### Step 4: Access Your Website

Copy the `website_domain` output URL and open it in your browser:

```
http://my-static-website-rahul-kujur-2024.s3-website-us-east-1.amazonaws.com
```

## 📊 Resources Created

The Terraform configuration creates:

| Resource | Description |
|----------|-------------|
| `aws_s3_bucket` | S3 bucket for website hosting |
| `aws_s3_bucket_versioning` | Enable versioning |
| `aws_s3_bucket_website_configuration` | Configure static website hosting |
| `aws_s3_bucket_public_access_block` | Control public access settings |
| `aws_s3_bucket_policy` | Allow public read access |
| `aws_s3_object` | Upload HTML and CSS files |

## 🔐 Security Considerations

- **Public Access**: The bucket policy allows public read-only access to objects
- **No Write Access**: The policy does NOT allow public uploads or deletions
- **Versioning**: Enabled for disaster recovery
- **Encryption**: Consider enabling server-side encryption in production

### Recommended Security Enhancements:

1. **Enable Encryption**:
   ```hcl
   resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
     # Add encryption configuration
   }
   ```

2. **Enable CloudFront** for caching and HTTPS
3. **Add logging** for access tracking
4. **Use IAM roles** instead of access keys

## 🗑️ Cleanup

To destroy all AWS resources and avoid charges:

```bash
terraform destroy
```

Type `yes` when prompted to confirm.

## 📈 Next Steps

After successful deployment, consider:

1. **Custom Domain**: Use Route 53 to map your domain
2. **HTTPS**: Add CloudFront distribution for HTTPS support
3. **CI/CD Pipeline**: Automate deployments
4. **Monitoring**: Add CloudWatch alarms
5. **Backup**: Configure S3 replication to another region

## 🐛 Troubleshooting

### Bucket Name Already Exists
**Error**: "bucket already exists"

**Solution**: Change the bucket name to something unique:
```bash
terraform apply -var="bucket_name=my-unique-name-2024"
```

### Access Denied
**Error**: "Access Denied" when viewing website

**Solution**: Ensure the bucket policy is correctly applied:
```bash
aws s3api get-bucket-policy --bucket your-bucket-name
```

### Files Not Found
**Error**: "index.html not found"

**Solution**: Ensure `index.html` and `styles.css` are in the project directory

### AWS Credentials
**Error**: "unable to get credentials"

**Solution**: Configure AWS credentials:
```bash
aws configure
# or
export AWS_ACCESS_KEY_ID="your-key"
export AWS_SECRET_ACCESS_KEY="your-secret"
```

## 📚 Additional Resources

- [Terraform AWS S3 Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
- [AWS S3 Static Website Hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
- [Terraform Best Practices](https://www.terraform.io/cloud-docs/recommended-practices)

## 🤝 Contributing

Feel free to modify and improve this project:

1. Update website content in `index.html`
2. Modify styling in `styles.css`
3. Add new resources to Terraform files
4. Test changes with `terraform plan`

## 📄 License

This project is provided as-is for educational purposes.

## 👨‍💻 Author

Created as part of Project 2: Host a Static Website on Amazon S3

---

**Last Updated**: 2024
