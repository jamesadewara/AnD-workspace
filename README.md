# AnD Project Workspace

## Overview

AnD is a comprehensive AI ecosystem providing intelligent recommendations and secure identity management. This repository serves as the central hub, using Git submodules to organize various services and components across the platform.

## Project Components

| Repository | Description | Link |
|------------|-------------|------|
| [**AnD-task-a**](AnD-task-a/) | **User Modeling Agent**: Simulates authentic Nigerian product reviews using a Probabilistic Rating Model (Price Shock). | [GitHub ↗](https://github.com/jamesadewara/AnD-task-a) |
| [**AnD-task-b**](AnD-task-b/) | **Recommendation Agent**: Contextual, agentic ranking engine with location-aware boosting and cold-start logic. | [GitHub ↗](https://github.com/jamesadewara/AnD-task-b) |
| [**and-frontend**](and-frontend/) | **Mobile-First Workspace**: Extreme-density UI with real-time reasoning observability (Agent Console). | [GitHub ↗](https://github.com/jamesadewara/and-frontend) |
| [**and-bruno-doc**](and-bruno-doc/) | **API Documentation**: Comprehensive Bruno collections for instant reproducibility. | [GitHub ↗](https://github.com/jamesadewara/and-bruno-doc) |

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
├── AnD-task-a/              # Reviews service submodule
├── and-frontend/                 # Frontend application submodule
├── AnD-task-b/    # Recommendation engine submodule
├── and-bruno-doc/            # API documentation submodule
├── AnD-data-cleaner/            # Data cleaning submodule
└── README.md                 # This file
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.