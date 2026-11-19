# Quick Start Guide - AWS S3 Static Website with Terraform

## ⚡ 5-Minute Quick Start

### Prerequisites
- Terraform installed (https://www.terraform.io/downloads.html)
- AWS credentials configured
- Git

### Step-by-Step:

#### 1️⃣ Update Bucket Name (REQUIRED)
Edit `variables.tf` and change the bucket name to something unique:
```hcl
variable "bucket_name" {
  default = "my-unique-website-name-2024"  # Change this!
}
```

#### 2️⃣ Initialize Terraform
```bash
terraform init
```

#### 3️⃣ View Resources to be Created
```bash
terraform plan
```

#### 4️⃣ Create Everything
```bash
terraform apply
```
Type `yes` when prompted.

#### 5️⃣ Get Your Website URL
Look for the output:
```
website_domain = "http://your-bucket-name.s3-website-us-east-1.amazonaws.com"
```

#### 6️⃣ Open in Browser
Copy and paste the URL into your browser. You should see your website!

---

## 🎯 Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `terraform init` | Initialize Terraform |
| `terraform plan` | Preview changes |
| `terraform apply` | Create resources |
| `terraform destroy` | Delete resources |
| `terraform output` | Show outputs |
| `terraform refresh` | Sync state |

---

## ✅ Verification

After `terraform apply`, verify your setup:

```bash
# Show all outputs
terraform output

# Check S3 bucket
aws s3 ls

# List bucket contents
aws s3 ls s3://your-bucket-name

# Verify bucket policy
aws s3api get-bucket-policy --bucket your-bucket-name
```

---

## 🔧 Customize Your Website

1. Edit `index.html` - Change content
2. Edit `styles.css` - Change styling
3. Add new files (images, etc.) to the project
4. Add new resources to `main.tf`:
   ```hcl
   resource "aws_s3_object" "new_file" {
     bucket = aws_s3_bucket.website_bucket.id
     key    = "new-file.txt"
     source = "${path.module}/new-file.txt"
   }
   ```
5. Run `terraform apply` again

---

## 🚨 Common Issues & Solutions

### "bucket already exists"
→ Change `bucket_name` in `variables.tf` to something unique

### "AccessDenied" when visiting website
→ Check AWS credentials with `aws configure`

### Website shows 404
→ Check file uploaded: `aws s3 ls s3://your-bucket-name/`

### Files not updating
→ Clear browser cache (Ctrl+Shift+Delete) or use Incognito mode

---

## 💰 Cost Estimation

- S3 Storage: ~$0.023/GB/month
- Data Transfer: ~$0.09/GB (outbound)
- Requests: ~$0.0004/1000 requests

For a small static website, expect <$1/month!

---

## 🎓 Learning Resources

- [Terraform S3 Module](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
- [AWS S3 Pricing](https://aws.amazon.com/s3/pricing/)
- [Static Website Guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)

---

## 📞 Support

If you encounter issues:

1. Check AWS credentials: `aws sts get-caller-identity`
2. Review Terraform state: `terraform state list`
3. Check S3 bucket: `aws s3api head-bucket --bucket your-bucket-name`
4. Review Terraform plan: `terraform plan`

---

**Happy hosting! 🚀**
