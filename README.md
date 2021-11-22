Terraform config

### AWS authentication

~/.aws/config:

```
[profile germis]
region = eu-central-1
```

~/.aws/credentials:

```
[germis]
aws_access_key_id = AWS_ACCESS_KEY_ID
aws_secret_access_key = AWS_SECRET_ACCESS_KEY
region = eu-central-1
```

To use the profile, simply `export AWS_PROFILE=germis`

```
$ aws sts get-caller-identity
{
    "UserId": "AWS_ACCESS_KEY_ID",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/my-user"
}
```