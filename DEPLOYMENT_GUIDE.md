# 📖 Complete Deployment Guide

## Overview

This guide walks you through deploying a static website on Amazon S3 using Terraform, step-by-step with screenshots and explanations.

## Prerequisites Checklist

Before starting, ensure you have:

- [ ] AWS Account created
- [ ] AWS Access Key ID and Secret Access Key
- [ ] Terraform installed (v1.0+)
- [ ] Git installed
- [ ] VS Code or terminal access
- [ ] This project cloned/extracted

---

## Part 1: Setup AWS Credentials

### 1.1 Get AWS Credentials

1. Log in to [AWS Console](https://console.aws.amazon.com)
2. Go to **IAM** → **Users**
3. Create a new user or use existing one
4. Navigate to **Security Credentials** tab
5. Click **Create Access Key**
6. Copy the **Access Key ID** and **Secret Access Key**

### 1.2 Configure AWS Credentials

#### Option A: Using AWS CLI (Recommended)

```bash
aws configure
```

You'll be prompted:
```
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-east-1
Default output format [None]: json
```

#### Option B: Using Environment Variables

Windows (PowerShell):
```powershell
$env:AWS_ACCESS_KEY_ID = "your-access-key"
$env:AWS_SECRET_ACCESS_KEY = "your-secret-key"
$env:AWS_DEFAULT_REGION = "us-east-1"
```

Windows (Command Prompt):
```cmd
set AWS_ACCESS_KEY_ID=your-access-key
set AWS_SECRET_ACCESS_KEY=your-secret-key
set AWS_DEFAULT_REGION=us-east-1
```

---

## Part 2: Prepare the Project

### 2.1 Navigate to Project Directory

```bash
cd "C:\Users\rahul.kujur\OneDrive - Accenture\Desktop\P2-Host-Static-Website"
```

### 2.2 Verify Project Files

Ensure these files exist:
```
├── main.tf
├── variables.tf
├── outputs.tf
├── index.html
├── styles.css
├── .gitignore
├── README.md
└── QUICKSTART.md
```

### 2.3 Edit Variables

Edit `variables.tf` and change the bucket name to something **globally unique**:

```hcl
variable "bucket_name" {
  description = "Name of the S3 bucket (must be globally unique)"
  type        = string
  default     = "my-website-your-name-2024"  # 👈 CHANGE THIS
}
```

**Bucket Naming Rules:**
- 3-63 characters long
- Lowercase letters, numbers, hyphens only
- Must be globally unique (no one else can have this name)
- Cannot start or end with hyphen
- Examples:
  - ✅ `rahul-website-2024`
  - ✅ `portfolio-rahul-kujur`
  - ❌ `Rahul-Website` (uppercase not allowed)
  - ❌ `rahul_website` (underscore not allowed)

---

## Part 3: Initialize Terraform

### 3.1 Initialize

Run the initialization command:

```bash
terraform init
```

**Expected Output:**
```
Initializing the backend...
Initializing provider plugins...
- Installed hashicorp/aws v5.x.x

Terraform has been successfully configured!
```

**What it does:**
- Downloads AWS provider plugin
- Creates `.terraform` directory
- Generates `.terraform.lock.hcl` lock file

### 3.2 Verify Installation

```bash
terraform version
```

Should show v1.0 or higher.

---

## Part 4: Plan Deployment

### 4.1 Review the Plan

```bash
terraform plan
```

**Expected Output:**
```
Terraform will perform the following actions:

  # aws_s3_bucket.website_bucket will be created
  + resource "aws_s3_bucket" "website_bucket" {
      + bucket            = "my-website-your-name-2024"
      + id                = (known after apply)
      ...
    }

  # aws_s3_bucket_policy.website_policy_public will be created
  + resource "aws_s3_bucket_policy" "website_policy_public" {
      + bucket = (known after apply)
      + policy = jsonencode(...)
    }

  # Additional resources...

Plan: 8 to add, 0 to change, 0 to destroy.
```

### 4.2 Review Resource Details

The plan creates:
1. **S3 Bucket** - Main storage
2. **Versioning** - For recovery
3. **Website Configuration** - Enables static hosting
4. **Public Access Block** - Allows public read
5. **Bucket Policy** - Public read permissions
6. **HTML Upload** - index.html
7. **CSS Upload** - styles.css

---

## Part 5: Deploy Infrastructure

### 5.1 Apply Configuration

```bash
terraform apply
```

You'll see the plan again and be asked to confirm:

```
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```

Type `yes` and press Enter.

### 5.2 Wait for Deployment

Terraform will:
1. Create S3 bucket
2. Enable website hosting
3. Configure permissions
4. Upload files
5. Output results

**Expected Time:** 30-60 seconds

### 5.3 Review Outputs

After successful deployment, you'll see:

```
Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

Outputs:

bucket_arn = "arn:aws:s3:::my-website-your-name-2024"
bucket_name = "my-website-your-name-2024"
s3_bucket_regional_domain_name = "my-website-your-name-2024.s3.amazonaws.com"
website_domain = "http://my-website-your-name-2024.s3-website-us-east-1.amazonaws.com"
website_endpoint = "my-website-your-name-2024.s3-website-us-east-1.amazonaws.com"
```

---

## Part 6: Access Your Website

### 6.1 Get the Website URL

From the outputs above, copy the **website_domain** URL:
```
http://my-website-your-name-2024.s3-website-us-east-1.amazonaws.com
```

### 6.2 Open in Browser

1. Open your browser (Chrome, Firefox, Edge, Safari)
2. Paste the URL in address bar
3. Press Enter
4. You should see your website! 🎉

### 6.3 Verify Content

The website should display:
- Purple gradient header
- "Welcome to My Static Website" title
- Features list
- Deployment steps
- Beautiful styling from styles.css

---

## Part 7: Verify in AWS Console

### 7.1 Check S3 Bucket

1. Go to [AWS S3 Console](https://s3.console.aws.amazon.com)
2. Find your bucket in the list
3. Click on bucket name
4. You should see:
   - `index.html` file
   - `styles.css` file
   - Both marked as publicly accessible

### 7.2 Check Bucket Properties

1. Click **Properties** tab
2. Scroll to **Static Website Hosting**
3. Should show:
   - Status: Enabled
   - Index document: index.html
   - Endpoint: http://your-bucket.s3-website-us-east-1.amazonaws.com

### 7.3 Check Bucket Policy

1. Click **Permissions** tab
2. Scroll to **Bucket Policy**
3. Should show policy allowing public read access

---

## Part 8: Update Website Content

### 8.1 Edit HTML

To change website content:

1. Open `index.html` in VS Code
2. Edit the content between `<h1>` tags and sections
3. Save the file
4. Run:
   ```bash
   terraform apply
   ```
5. Refresh your browser

### 8.2 Edit Styling

To change website appearance:

1. Open `styles.css` in VS Code
2. Modify colors, fonts, layout
3. Save the file
4. Run:
   ```bash
   terraform apply
   ```
5. Refresh your browser (Ctrl+Shift+Delete to clear cache)

### 8.3 Add New Files

To add images, fonts, etc.:

1. Add file to project directory
2. Add to `main.tf`:
   ```hcl
   resource "aws_s3_object" "my_image" {
     bucket = aws_s3_bucket.website_bucket.id
     key    = "image.jpg"
     source = "${path.module}/image.jpg"
   }
   ```
3. Run `terraform apply`

---

## Part 9: Use Terraform Outputs

### 9.1 Show All Outputs

```bash
terraform output
```

### 9.2 Show Specific Output

```bash
terraform output website_domain
```

### 9.3 Export to File

```bash
terraform output -json > outputs.json
```

---

## Part 10: Cleanup & Destroy

### 10.1 Destroy Resources

When done, delete all AWS resources to avoid charges:

```bash
terraform destroy
```

Confirm with `yes`.

### 10.2 Verify Deletion

```bash
aws s3 ls
```

Bucket should no longer appear.

---

## 🐛 Troubleshooting Guide

### Problem: "bucket already exists"

**Error:**
```
Error: creating Amazon S3 (s3) bucket: BucketAlreadyOwnedByYou: 
The bucket already exists and is owned by me.
```

**Solution:**
Change bucket name in `variables.tf` to something unique:
```bash
terraform apply -var="bucket_name=my-new-unique-name-2024"
```

---

### Problem: "AccessDenied" or "InvalidAccessKeyId"

**Error:**
```
Error: error configuring Terraform AWS Provider: 
...InvalidAccessKeyId.The AWS Access Key Id you provided does not exist
```

**Solution:**
1. Verify credentials with:
   ```bash
   aws sts get-caller-identity
   ```
2. If error, reconfigure:
   ```bash
   aws configure
   ```
3. Use fresh AWS credentials

---

### Problem: "AccessDenied" accessing website

**Error:** When visiting the website URL, you see "AccessDenied"

**Solution:**
1. Check bucket is public:
   ```bash
   aws s3api get-bucket-policy --bucket your-bucket-name
   ```
2. If empty, re-run:
   ```bash
   terraform apply
   ```

---

### Problem: "No such file or directory"

**Error:**
```
Error: opening ../path/to/index.html: 
no such file or directory
```

**Solution:**
Ensure you're in correct directory:
```bash
cd "C:\Users\rahul.kujur\OneDrive - Accenture\Desktop\P2-Host-Static-Website"
ls  # or dir on Windows
```

---

### Problem: Website shows 404

**Error:** Visiting URL shows "404 Not Found"

**Solution:**
1. Verify files uploaded:
   ```bash
   aws s3 ls s3://your-bucket-name/
   ```
2. Check index.html exists:
   ```bash
   aws s3 ls s3://your-bucket-name/index.html
   ```
3. If not there, re-run:
   ```bash
   terraform apply
   ```

---

### Problem: Stale content in browser

**Issue:** Changes not appearing after uploading new files

**Solution:**
Hard refresh your browser:
- Chrome: Ctrl+Shift+R
- Firefox: Ctrl+Shift+R
- Safari: Cmd+Shift+R
- Or use Incognito/Private mode

---

## 📊 Monitoring & Next Steps

### Monitor Website Performance

```bash
# Check S3 bucket size
aws s3 ls s3://your-bucket-name/ --recursive --summarize

# Check access logs
aws s3api head-bucket --bucket your-bucket-name
```

### Next Steps to Level Up

1. **Add Custom Domain**
   - Register domain (Route 53 or external registrar)
   - Create Route 53 record pointing to S3

2. **Enable HTTPS**
   - Add CloudFront distribution
   - Use AWS Certificate Manager

3. **Enable Caching**
   - Configure CloudFront
   - Set cache-control headers

4. **Monitor Access**
   - Enable S3 logging
   - Setup CloudWatch alarms

5. **Backup**
   - Enable S3 versioning
   - Setup cross-region replication

---

## 📝 Useful Commands Summary

```bash
# Initialization
terraform init                    # Initialize Terraform

# Planning & Deployment
terraform plan                    # Preview changes
terraform apply                   # Apply changes
terraform destroy                 # Delete resources

# State Management
terraform show                    # Show current state
terraform state list              # List resources
terraform refresh                 # Update state

# Output Management
terraform output                  # Show all outputs
terraform output -json            # JSON format

# AWS CLI Commands
aws configure                     # Setup credentials
aws s3 ls                         # List buckets
aws s3 ls s3://bucket-name        # List bucket contents
aws s3api get-bucket-website-configuration --bucket your-bucket-name
aws sts get-caller-identity      # Verify credentials
```

---

## ✅ Deployment Checklist

- [ ] AWS credentials configured
- [ ] Terraform installed
- [ ] Project directory prepared
- [ ] Bucket name changed in variables.tf
- [ ] `terraform init` completed
- [ ] `terraform plan` reviewed
- [ ] `terraform apply` successful
- [ ] Website URL accessible in browser
- [ ] Files visible in S3 console
- [ ] Content displaying correctly
- [ ] Git repository initialized and committed

---

## 🎓 Learning Resources

- [AWS S3 Documentation](https://docs.aws.amazon.com/s3/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest)
- [Static Website Hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
- [Terraform Best Practices](https://www.terraform.io/language/values/locals)

---

**Congratulations! Your static website is now live! 🚀**
