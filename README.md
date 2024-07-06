# Question:
Create a Bicep template that will deploy three Windows web apps to Azure, all to the same hosting plan. The hosting plan has already been deployed by a different template. One of the web apps should have its time zone set to Brisbane Australia. The web app segment of the template should be reusable by other templates.

# Tasks:
[x] Create a Bicep template that will deploy three Windows web apps to Azure.
[x] All web apps use the same hosting plan.
[x] One of the web apps should have its time zone set to Brisbane Australia.
[?] The web app segment of the template should be reusable by other templates.

# Context:
The webplan.bicep template was used to help me test and simulate the scenario as per the question.

# How to Run:
Please read `deployment.ps1` for commands that can be executed to deploy the web apps and other associated conponents (i.e. "webplan")
Recommend reading before executing.

# Query:
I do not completely understand what "web app segment" refers to. After some exploration with the Biceps Template documentation I am wondering if this is refering to the site configuration specifically. I decided to not declare the last task complete because I lack understanding, but gave it my best to still allow the template to be used for other resource groups and server farms.

# Outside Help:
Used documentation from Mircosoft for Biceps Templates.
[Link here](https://learn.microsoft.com/en-us/azure/templates/microsoft.web/serverfarms?pivots=deployment-language-bicep)

Had issues deploying Microsoft.Web/serverfarm to be WinOS based and not Linux
Referenced StockOverflow 74166407 for assistance. [Link here](https://stackoverflow.com/questions/74166407/bicep-deploys-a-linux-app-service-plan-regardless-of-kind-defined)

I had to use ChatGPT to work out what a warning in my webapp biceps file was referring to. See [here](https://chatgpt.com/share/0c78d88e-b85b-460e-bee5-3220b34ce1fc) for context on resourceId.

I forgot how to split a command in powershell across multiple lines. Too much `/bin/bash`. I'll come out and admit that. 