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
Updated the `azurerm_windows_function_app` module allowing for fully customizable function app config
Really want to do the same for the other resources but not sure on time
Realistically need to re structure the entire layout.

Will add Workflow files if i have the time.
