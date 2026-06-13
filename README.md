# Zero-Trust Three-Tier AWS Web App

Production-pattern web application on AWS demonstrating defense in depth and zero-trust principles. Everything codified with Terraform.

> Portfolio project demonstrating AWS Cloud Security Engineer skills.

---

## Status

🚧 In progress. Week 1 of 8.

---

## Goal

Build a hardened three-tier web application on AWS that mirrors real-world enterprise security patterns. 

**Every layer secured. Every resource codified. Every decision documented**


This project demonstrates the ability to:

- Design secure cloud architectures using defense in depth
- Implement zero-trust principles at network, identity, and data layers
- Codify infrastructure with reusable Terraform modules
- Apply compliance frameworks (NIST CSF 2.0, CIS AWS Foundations)
- Document threats using the STRIDE methodology
- Extend traditional security thinking to AI workloads

---

## Architecture

Three application tiers deployed across three Availability Zones inside a custom VPC.

| Tier | Subnet type | Components | Internet route |
|------|-------------|------------|----------------|
| Web | Public | Application Load Balancer, NAT Gateway | Inbound 443 only |
| App | Private | EC2 Auto Scaling group | Outbound via NAT |
| Data | Isolated | Aurora Serverless v2 | None |

### Security controls

**Perimeter**
- AWS WAF with managed rule groups (SQLi, XSS, common attacks)
- Per-IP rate limiting
- ACM-issued TLS 1.3 certificate
- HTTPS-only listener (HTTP redirects)

**Network**
- VPC endpoints for AWS service traffic (no public internet egress)
- Gateway endpoints (S3, DynamoDB) — free
- Interface endpoints (Secrets Manager, KMS, SSM) — PrivateLink
- Endpoint policies restrict access to project's account only
- VPC Flow Logs to CloudWatch

**Identity**
- IAM least privilege (zero wildcard actions)
- IAM Access Analyzer validates external access and unused permissions
- Permissions boundaries on all roles
- IAM Identity Center for human access (no console root use)

**Data at rest**
- KMS customer-managed keys per data class (RDS, Secrets, S3)
- Key rotation enabled
- Explicit key policies (not just default)

**Data in transit**
- TLS 1.3 enforced on ALB
- TLS between application and database

**Secrets**
- AWS Secrets Manager with 30-day automatic rotation
- Lambda rotation function
- Application reads via IAM role (no embedded credentials)

**Compliance**
- AWS Config recording all resource changes
- CIS AWS Foundations Benchmark conformance pack
- Auto-remediation via SSM documents

**Visibility**
- CloudTrail organization trail (multi-region)
- CloudWatch dashboard with key metrics
- CloudWatch alarms via SNS

📐 _Architecture diagram coming Week 2._

---

## Tech stack

- **Cloud**: AWS
- **Infrastructure as Code**: Terraform 1.6+
- **CI/CD**: GitHub Actions with OIDC federation (no long-lived AWS keys)
- **Security scanning**: Checkov, tfsec, gitleaks (pre-commit + PR-blocking)
- **Languages**: HCL (Terraform), Python (Lambda)

---

## Skills demonstrated

- Multi-AZ VPC design with three-tier subnet segmentation
- IAM least privilege validated by Access Analyzer
- KMS customer-managed key hierarchy
- Secrets Manager with automatic rotation
- WAF rule writing and per-IP rate limiting
- VPC endpoint architecture (interface and gateway types)
- Endpoint policies for data exfiltration prevention
- Terraform with reusable modules
- Policy as Code with Checkov and tfsec
- OIDC federation for CI/CD
- AWS Config compliance automation
- STRIDE threat modeling
- NIST CSF 2.0 control mapping

---

## Documentation

- [📐 Architecture Diagram](docs/diagrams/project-a-architecture.svg) — _coming Week 2_
- [🎯 Threat Model (STRIDE)](THREAT-MODEL.md) — _coming Week 8_
- [📊 NIST CSF 2.0 Mapping](NIST-CSF-MAPPING.md) — _coming Week 8_
- [📝 Architecture Decision Records](docs/ADRs/) — _added per decision_
- [💰 Cost Breakdown](COST.md) — _coming Week 8_
- [🔮 Future Improvements](FUTURE-IMPROVEMENTS.md) — _living document_

---

## Quick start

Prerequisites: AWS account, Terraform 1.6+, AWS CLI configured via SSO.

```bash
# Clone
git clone https://github.com/Augusto-ZM/Zero-Trust-Three-Tier-AWS-Web-APP.git
cd zero-trust-aws-app

# Configure backend
# (See BUILD-PLAN.md for full setup)

# Deploy
cd environments/dev
terraform init
terraform plan
terraform apply

# Destroy when done
terraform destroy
```

📚 Full setup guide: [BUILD-PLAN.md](BUILD-PLAN.md)

---

## Cost

Estimated $25-30 total for the 8-week build with disciplined teardown between sessions.

Single biggest cost trap: NAT Gateway at ~$1/day. Always destroy when not in use.

📊 Detailed breakdown: [COST.md](COST.md) — _coming Week 8_

---

## Related projects

- [threat-detection-pipeline](https://github.com/YOURNAME/threat-detection-pipeline) — Multi-account threat detection and auto-response that monitors this workload

---

## About

Built by **Augusto F. Zorrilla Mendez** as portfolio work for Cloud Security Engineer roles.

🎓 Master's in Cybersecurity, University of Nebraska Omaha (graduating Dec 2026)
📜 AWS Solutions Architect Associate (in progress)
📜 AWS Security Specialty (planned)

🔗 [LinkedIn](https://linkedin.com/in/YOURNAME) · [GitHub](https://github.com/YOURNAME) · [Blog](https://yourblog.com)

---

## License

[MIT](LICENSE)

---

_This README is a living document. Sections marked "coming" will be filled in as build progresses through the 8-week plan documented in BUILD-PLAN.md._
