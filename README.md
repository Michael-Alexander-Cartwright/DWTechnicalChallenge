# Question:
Write a PowerShell Core script that uses Azure PowerShell. The script should change the DTU of a SQL database or elastic pool (your choice). The script will be called by an external system for different customers, so should be parameterised.

# Tasks:
[x] Write a PowerShell Core script that uses Azure PowerShell.
[x] The script should change the DTU of a SQL database or elastic pool (your choice).
[x] The script will be called by an external system for different customers, so should be parameterised.

# Context:
I decided not to delve to far into error handling and returning Azure output because I am not sure of how the "external system" works and if it can handle this fucntionality. I decided to complete the main objective. I feel that it is fair to say that this script and how it can interract with other "external systems" can be improved.

I chose the elastic pool option because I could not figure out for the life of me where to find the DTU values on the Sql database. It got late. So I admit that I went with the easier but WOW potentially expensive option by using a Basic tier elastic pool to test this fucntionality out.  


Please see `updateElasticPoolDTU.ps1` for how to execute. I left my test values in the `.EXAMPLE` section.

# Outside Help:
The dreaded PowerShell I am not going to recognise your input variable of 0 as an int for this parameter scenario.
Went straight back to [here](https://stackoverflow.com/questions/30007013/0-not-an-int-in-powershell) to fix the issue.

Asked ChatGPT what the standard the header section of a PowerShell script is supposed to look like. That way I can keep to a standard.   