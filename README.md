# Data Retrieval Project


This project fetches and manages data from an external API, enabling version control of data files with size restrictions based on specific versions.

## Project Structure

- `.github/workflows/code_linter.yml` — GitHub Actions workflow for linting and code quality.
- `datahub/data.json` — Stores the fetched data.
- `params.yml` — Configures the `version` and `size` variables for data fetching.
- `retrieve_data.sh` — Script to fetch data, verify changes, and update `data.json` if necessary.

## Setup

1. **Clone the Repository**
   ```bash
   git clone <https://github.com/Akp002/Akp-Week6.git>
   cd <Akp-Week6>
Install Dependencies

yq for YAML parsing
jq for JSON parsing
curl for data retrieval
Run the Script

Copy code
./retrieve_data.sh
The script fetches data based on the version in params.yml, checks if there are any changes, and updates data.json if needed.

#GitHub Actions

The code_linter.yml in .github/workflows runs linters to maintain code quality.