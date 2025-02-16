# Azure Functions Assignment

This assignment is designed to test your Terraform and Azure knowledge in a real-world scenario.

This repo closely resembles a lightweight version of real code used to create function apps in our Azure environment. We'd like you to use your experience to refactor the code.

The code currently has some limitations:

* The function definition is a little rigid and each is created with exactly the same configuration
* Access to Azure services e.g. Key Vault, may not adhere to security best practices
* The directory structure makes the code difficult to work on

## Objectives

* Add a new function called `products-denormalizations`
* Add the ability to specify custom configuration per function e.g. scaling settings
* Use your experience to make changes that would optimise cost, and improve security
* Update the readme to include:
    * A description of the changes made, and the rationale behind them
    * Any future enhancements outside of the scope of this exercise that you might make

### Extra credit
* An explanation of how you might test your infrastructure prior to deployment
* A simple github actions YAML file that will deploy the solution to Azure

## Considerations

You should consider:

* How your solution scales to create _n_ functions with a variety of configuration options
* Whether what you've built is cost-effective (The resources used here are on the free tier for the purpose of the exercise, but you should be able to articulate how you might apply the most cost-effective configurations in a production environment)
* Reusability i.e. another team wishes to create a function, could your code be reused by other respositories?
* Azure resource naming and tagging best practices
* Reliability and monitoring options

## Submission

To submit your solution:
* Clone this repo
* Commit your finished solution to your own repo
* Grant `scollins-smartwyre`, `andysbolton` and `scooney-smartwyre` access to your clone your repo for review

##  UPDATES
Updated the `azurerm_windows_function_app` module, allowing for a fully customisable function app config. Really want to do the same for the other resources but not sure on time. Realistically need to restructure the entire layout.

Created new modules for Key Vault and Resource Group, along with a function app for neatness.
Would normally have a subfolder under deployments, depending on how you would like to organise it—either a subfolder per Azure resource or a subfolder per business application with related resources inside.

Added a fake backend.tf to deployment. Would require one in each subfolder if I went that route.

Not actually worked on a function app, so not 100% sure on cost optimisation. I guess it would be scaling up and down due to demand. If they have any pricing plans, use them. Scale if possible in line with demand.

For security, do not make it publicly accessible—only give it the permissions it requires for the Key Vault, e.g., get secrets. Remove public access from Key Vault—only allowed IPs can access it. Use the role assignment part so specific users/MIs can access it.

For testing, run a terraform validate and terraform plan. Would then have a dev/UAT environment for deploying to test initially before production.

Added reusable workflows:
Best when you have multiple Terraform repositories, e.g., for different business units. Instead of having multiple workflows, centralise them in a reusable repo holding reusable workflows, then caller workflows in each Terraform repo.

This current way is using a GitHub App, as this would be run on an on-prem runner. Could simplify it if using cloud-hosted.


