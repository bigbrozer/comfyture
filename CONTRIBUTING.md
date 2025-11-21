# Contributing guide

## Overview

I welcome contributions to the project. Follow these guidelines to help ensure your contributions are accepted and maintain the project's quality.

This project is using [Task](https://taskfile.dev/) as the task runner. Refer to the `Taskfile.yml` or run `task -l` once installed.

## Prepare your environment

1. **Install ASDF**
   * Follow [installation instructions](https://asdf-vm.com/guide/getting-started.html) to setup `asdf`.

2. **Plugin installation**
   * Install the needed plugins (listed in `.tool-versions`):

     ```bash
     asdf plugin add task
     asdf plugin add git-cliff
     ```

3. **Install tools**
   * Install all tools using versions in `.tool-versions`:

     ```bash
     asdf install
     ```

You're ready to continue !

## Getting Started

1. **Discuss changes**
   * Before submitting new changes, discuss them by submitting [a new issue](https://github.com/bigbrozer/comfyture/issues/new).

2. **Fork the Repository:**
   * Go to the [repository on GitHub](https://github.com/bigbrozer/comfyture).
   * Click on the "Fork" button to create a copy of the repository in your GitHub account.

3. **Clone the Forked Repository:**
   * Open your terminal or command prompt.
   * Clone the forked repository to your local machine:

     ```bash
     git clone <fork_url>
     cd your-repo
     ```

4. **Create a New Branch:**
   * Create a new branch for your feature or bug fix:

     ```bash
     git checkout -b feature/your-branch-name
     ```

5. **Make Your Changes:**
   * Make your changes to the project files.

6. **Commit Your Changes:**
   * Add your changes to the staging area:

     ```bash
     git add .
     ```

   * Commit your changes with a [conventional commit](https://www.conventionalcommits.org/en/v1.0.0/#summary) message:

     ```bash
     git commit -m "feat: my new feature"
     ```

7. **Push Your Changes:**
   * Push your changes to your forked repository:

     ```bash
     git push origin feature/your-branch-name
     ```

## Test your changes

1. **Build the image locally**
   * Run `task build` to launch the building image process locally. It will end with a local docker image tagged `bigbrozer/comfyture:latest`.

2. **Run the stack locally**
   * Run `task tests` to execute a local ComfyUI instance using docker compose.
   * Open your browser on [http://localhost:8188](http://localhost:8188).

## Submitting a Pull Request

1. **Create a Pull Request:**
   * Go to your forked repository.
   * Click on the "Pull Requests" tab.
   * Click on "New Pull Request".
   * Select the base branch as `main`.
   * Select the branch you created (`feature/your-branch-name`).
   * Write a clear and concise title for your pull request and provide a detailed description of your changes.

2. **Review and Edit:**
   * I will review your pull request. I may provide feedback or request changes.
   * Edit your changes as needed and push them to your branch:

     ```bash
     git push origin feature/your-branch-name
     ```

3. **Resolve Conflicts:**
   * If there are conflicts, resolve them and push the changes again:

     ```bash
     git push origin feature/your-branch-name
     ```

4. **Merge the Pull Request:**
   * Once the pull request is approved and all conflicts are resolved, I will merge it into the `main` branch.

## Contributing Guidelines

* **Keep Changes Small:** Keep each pull request focused on a single change or fix.
* **Document Your Changes:** If you introduce new features or changes, document them in the project's README.
* **Test Your Changes:** Ensure that your changes do not break existing functionality and that all tests pass.
* **Respect Others:** Be respectful and considerate of other contributors and author.

## License

By contributing to this project, you agree to the terms of the [MIT License](https://github.com/bigbrozer/comfyture/blob/main/LICENSE).
