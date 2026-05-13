# AnD Project Workspace

## Overview

AnD is a comprehensive AI ecosystem providing intelligent recommendations and secure identity management. This repository serves as the central hub, using Git submodules to organize various services and components across the platform.

## Project Components

| Component | Description | Repository |
|-----------|-------------|-----------|
## Project Repositories
* 📂 **[AnD Task A](https://github.com/jamesadewara/AnD-task-a)** - Backend/Task logic A.
* 📂 **[AnD Task B](https://github.com/jamesadewara/AnD-task-b)** - Backend/Task logic B.
* 💻 **[AnD Frontend](https://github.com/jamesadewara/AnD-frontend)** - Main user interface.

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
├── AnD-frontend/                 # Frontend application submodule
├── AnD-task-b/    # Recommendation engine submodule
├── AnD-bruno-doc/            # API documentation submodule
└── README.md                 # This file
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.