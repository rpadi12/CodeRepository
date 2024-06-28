#The below PowerShell script helps you to remove the mask ACL permissions in ADLS Gen 2 storage account.

#By using the following materials or sample code you agree to be bound by the license terms below and the Microsoft Partner Program Agreement the terms of which are incorporated herein by this reference. 
#These license terms are an agreement between Microsoft Corporation (or, if applicable based on where you are located, one of its affiliates) and you. Any materials (other than this sample code) we provide to you are for your internal use only. Any sample code is provided for the purpose of illustration only and is 
#not intended to be used in a production environment. We grant you a nonexclusive, royalty-free right to use and modify the sample code and to reproduce and distribute the object code form of the sample code, provided that you agree: (i) to not use Microsoft’s name, logo, or trademarks to market your software product 
#in which the sample code is embedded; (ii) to include a valid copyright notice on your software product in which the sample code is embedded; (iii) to provide on behalf of and for the benefit of your subcontractors a disclaimer of warranties, exclusion of liability for indirect and consequential damages and a reasonable 
#limitation of liability; and (iv) to indemnify, hold harmless, and defend Microsoft, its affiliates and suppliers from and against any third party claims or lawsuits, including attorneys’ fees, that arise or result from the use or distribution of the sample code." 
#Note : User should have sufficient permissions to create the directory in the storage account

Select-AzSubscription -SubscriptionId "XXXXX"
$ctx = New-AzStorageContext -StorageAccountName "XXXXX" -StorageAccountKey "XXXXXXX"
$acl = Get-AzDataLakeGen2Item -Context $ctx -FileSystem "sample-container" -Path "filesystem-path"
$acl.Acl = $acl.Acl | Where-Object { $_.AccessControlType -ne 'mask' }
Set-AzDataLakeGen2AclRecursive -Context $ctx -FileSystem "sample-container" -Path "filesystem-path" -Acl $acl.Acl
