# AnD Project Workspace

## Overview

AnD is a comprehensive AI ecosystem providing intelligent recommendations and secure identity management. This repository serves as the central hub, using Git submodules to organize various services and components across the platform.

## Project Components

| Component | Description | Repository |
|-----------|-------------|-----------|
| **Recommendation System** | Core AI engine for personalized recommendations | [AnD-ai-recommendation-system](https://github.com/jamesadewara/AnD-ai-recommendation-system) |
| **Auth System** | Identity and access management service | [AnD-ai-auth-system](https://github.com/jamesadewara/AnD-ai-auth-system) |
| **Frontend** | User interface and client-side application | [AnD-ai-frontend](https://github.com/jamesadewara/AnD-ai-frontend) |
| **Infrastructure as Code** | IaC for provisioning infrastructure resources | [AnD-iac](https://github.com/jamesadewara/AnD-iac) |
| **API Documentation** | Bruno API collections and interactive documentation | [AnD-ai-bruno-api-doc](https://github.com/jamesadewara/AnD-ai-bruno-api-doc) |

## Getting Started

### Clone the Workspace

Clone this workspace along with all sub-repositories:

```bash
git clone --recursive https://github.com/jamesadewara/AnD-workspace.git
cd AnD-workspace
```

If you already cloned without `--recursive`, initialize the submodules:

```bash
git submodule update --init --recursive
```

### Update All Repositories to Latest Main

Run this from the root of `AnD-workspace/` to ensure every submodule is on the `main` branch at the latest commit:

```powershell
git submodule foreach "git checkout main 2>/dev/null || git checkout master 2>/dev/null && git pull origin main 2>/dev/null || git pull origin master 2>/dev/null && git --no-pager log --oneline -1"
```

Or as a one-liner:

```bash
git submodule foreach '
  echo "==> Updating $name"
  git checkout main 2>/dev/null || git checkout master 2>/dev/null
  git pull origin main 2>/dev/null || git pull origin master 2>/dev/null
  git --no-pager log --oneline -1
  echo ""
'
```

### Update Submodules (Alternative)

To pull the latest submodule references defined in the parent repo:

```bash
git submodule update --remote --merge
```

> **Note:** `--remote` fetches the latest from upstream but may leave you in detached HEAD. Use the `git submodule foreach` approach above if you want to actively work on `main` in each repo.

## Repository Structure

```
AnD-workspace/
├── auth-system/              # Auth service submodule
├── frontend/                 # Frontend application submodule
├── recommendation-system/    # Recommendation engine submodule
├── AnD-iac/                 # Infrastructure as Code submodule
├── bruno-api-doc/            # API documentation submodule
└── README.md                 # This file
```

## License

This project is licensed under the APACHE 2.0 License. See the [LICENSE](LICENSE) file for details.