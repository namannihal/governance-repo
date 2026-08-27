# Azure - Additional Application Onboarding to existing Subscriptions

This page describes the steps and processes that application teams need to follow to request an Additional application onboarding to an existing Subscription in the all tenants of the Azure Core Platform built during the LSEG-Microsoft Partnership.

When you request an application onboarding, the automation pipeline will create the application resource group under the existing subscription. Also, the Entra ID groups (AD group) will be created with the default accesses.

1\. Planning and Prerequisites Workflow2. Additional App Onboarding Request Workflow

## Planning and Prerequisites

🔍This section lists the various preparation steps application teams must perform before requesting an application onboarding:

1.  **Application ID** - <a href="/sites/CloudCentral/SitePages/How-can-I-create-an-App-ID-in-Lean-IX.aspx?xsdata=MDV8MDJ8fDE3NGMyZWQyYzZjZjRlNDI0MTYxMDhkYzkxM2EyMmVhfDI4N2U5ZjBlOTFlYzRjZjBiN2E0YzYzODk4MDcyMTgxfDB8MHw2Mzg1NDQ5MjYwNTk2NzYwMDF8VW5rbm93bnxWR1ZoYlhOVFpXTjFjbWwwZVZObGNuWnBZMlY4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazkwYUdWeUlpd2lWMVFpT2pFeGZRPT18MXxMMk5vWVhSekx6RTVPakV6T0RVeU5XUTJMVEU0WldJdE5ERXhOUzA1Tm1NMkxXUmlNRFZtWVRFMll6STVOMTh4T0RBNU4yUTRZUzAyTW1ZeUxUUTFPV0V0WWpGaE5DMWtPRGMzTURKa056SmlNR0pBZFc1eExtZGliQzV6Y0dGalpYTXZiV1Z6YzJGblpYTXZNVGN4T0RnNU5UZ3dOVGcxT0E9PXxiYWE3MzUwODg3YzU0ZWJjNDE2MTA4ZGM5MTNhMjJlYXwyYjgxYmQ4Yjg0MzQ0YmNlOGY3YjQzY2FmYmIyODRiMQ%3D%3D&amp;sdata=OUEvU3lwNkxYdDRlMGN5cDIxblpwU0hkd3pJMk5mc2lGMnNmWWdjTWZ2az0%3D&amp;ovuser=287e9f0e-91ec-4cf0-b7a4-c63898072181%2cneethu.jose%40lseg.com&amp;OR=Teams-HL&amp;CT=1718896054177&amp;clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiIyNy8yNDA1MzEwNjMwMCIsIkhhc0ZlZGVyYXRlZFVzZXIiOmZhbHNlfQ%3D%3D" data-interception="off" target="_blank" rel="noopener noreferrer"><u>Create a 5-digit Application ID in LeanIX and reflect in ServiceNow. </u></a>

    - **ServiceNow Support group** for the team that will be supporting the application, this is another pre-requisite for ensuring your app is in ServiceNow: [<u>Group Management Request (service-now.com)</u>](https://lseg.service-now.com/esc?id=sc_cat_item&table=sc_cat_item&sys_id=deed927a1b45c1106bba7ea5464bcba7)
    - **SACM Request** to Create Application Services in ServiceNow CMDB (LeanIX Factsheet must be approved for 24hrs before submitting this request): 
      - **For single** **requests**: <a href="https://lseg.service-now.com/esc?id=sc_cat_item&amp;table=sc_cat_item&amp;sys_id=152ac7bedb9c2410b3ff50abd3961901&amp;searchTerm=SACM" data-interception="off" target="_blank" rel="noopener noreferrer"><u>SACM - Application Services - New Map - Support Hub (service-now.com)</u></a> 

      - **For** **bulk requests**: <a href="https://lseg.service-now.com/esc?id=sc_cat_item&amp;table=sc_cat_item&amp;sys_id=1a8dde7e837c165cd84b9860ceaad391&amp;searchTerm=application%20service" data-interception="off" target="_blank" rel="noopener noreferrer"><u>SACM - Application Services - New Map – Bulk Request (service-now.com)</u></a>  
         

2.  **Governance**<span class="fontColorRed">**\*\***</span>  - Approvals from **Architecture Governance process**. All applications moving to cloud are considered Architecturally significant and application teams will need to go through the [<u>Architecture Governance process</u>](https://lseg.service-now.com/esc?id=kb_article&sysparm_article=KB000021508) before requesting an Azure Subscription in ServiceNow.
    1.  You can complete your ASA in this <a href="https://lseg.service-now.com/esc?id=sc_cat_item&amp;sys_id=3188347d1b53a11037fddd31b24bcb32" data-interception="off" target="_blank" rel="noopener noreferrer"><u>link</u></a> which will create the Governance ID in OSM ServiceNow (One Service management, aka. ServiceNow Greenfield). Please ensure you enter your LeanIX App ID to the ASA.

    2.  As part of the governance process the application teams (e.g. \<APP-11111\>) will need to create a STAR document that will need to be submitted and reviewed at CTEF (Cloud Transformation Engineering Forum).

    3.  Ensure the Governance ID is “Approved” in the SNOW portal after you have obtained CTEF verbal approval.  
          
        <span class="fontColorRed">**\*\***</span> Please note that a Governance ID (ASA) is not required for Dev-POC Subscriptions (does not allow the setup of on-prems connectivity in that sub type). [<u>Please check here for more information about subscription types</u>](/sites/CloudCentral/SitePages/LMP-Azure-Subscription-Types.aspx).  
         

3.  **-C Accounts** - In order to get access to the subscription, you will need a -c account. Please follow the instructions in this link to get a -c account: [<u>LMP Azure - How to request a -C account for accessing Privileged roles in LMSP0 and LSEG.com (sharepoint.com)</u>](/sites/CloudCentral/SitePages/LMP-Azure-Requesting-a-%27-C%27-account.aspx)  
     

4.  **DXOne Onboarding** - We recommend getting a DXOne project onboarded before requesting the application onboarding so the Cloud Engineering team can then link the subscription and Service Principal to the existing project: [<u>DXOne Onboarding - Support Hub (service-now.com)</u>](https://lseg.service-now.com/esc?id=sc_cat_item&table=sc_cat_item&sys_id=25e78c001b2c6110a25b8326464bcb12)  
     

5.  Ensure you plan ahead and start gathering important details that will be required for getting a subscription. e.g.:

    1.  **Group Distribution list** who will “own” the subscription: [Creating or deleting email distribution lists (sharepoint.com)](/sites/Technology-Support/SitePages/how-to-create-a-distribution-group.aspx)

    2.  **Cost center** for which all cloud spend will be charged to. 

    3.  **Clarity Project Code** on which the application team charges their work hours

## Request an Additional Application onboarding in ServiceNow 📦

Before you request for an app onboarding in an existing subscription, ensure that you have met the [<u>prerequisites</u>](/sites/CloudCentral/SitePages/LMP-Azure---Additional-Application-Onboarding-to-existing-Subscriptions.aspx#planning-and-prerequisites) and that you agreed with the subscription Primary Application owners that they are in agreement for a new app to be onboarded to their subscription.  
  
After getting a 5-digit App ID and obtaining an Approved Governance ID, the application team can submit the Application Onboarding request:

👉 Click here to request an Additional App Onboarding in ServiceNow<a href="https://lseg.service-now.com/esc?id=sc_cat_item&amp;table=sc_cat_item&amp;sys_id=d35a78c71bf6c2507224a609b04bcbd6" data-sp-prop-name="button.linkUrl"></a>

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th data-valign="top"><span><strong>Field Name</strong></span></th>
<th data-valign="top"><span><strong>Description and Valid options</strong></span></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>LeanIX Application Name</strong><br />
<span><strong>LeanIX Application ID</strong></span><br />
(This has to be a 5-digit application ID)</td>
<td>Main Service/Application being onboarded to the subscription</td>
</tr>
<tr>
<td data-valign="top"><span><strong>Subscription Name</strong></span><br />
<span><strong>Subscription ID</strong></span></td>
<td data-valign="top"><span>Enter the subscription name and ID on which you are attempting to get onboarded.</span></td>
</tr>
<tr>
<td><strong>Approved Governance ID</strong></td>
<td><p>All new Application onboardings to Cloud are considered to be Architecturally Significant, hence you need a <a href="https://lseg.service-now.com/x/lsegp/cto/list/params/list-id/7e2231c31b3fa15037fddd31b24bcbc3/tiny-id/idSNOqTI7f6mtwbqVjtfz3oCtP7Mnxvk"><u>Governance ID</u></a>. A Governance ID is issued once the Application SAD/STAR has passed through the Architecture Governance process. You will need a Governance ID to submit this form. For more information, please visit <a href="/sites/ats/SitePages/Welcome-to-the.aspx"><u>this link</u></a>. "For a list of all completed governance items, click <a href="https://lseg.service-now.com/x/lsegp/cto/list/params/list-id/7e2231c31b3fa15037fddd31b24bcbc3/tiny-id/idSNOqTI7f6mtwbqVjtfz3oCtP7Mnxvk"><u>this link</u></a>.</p>
<p><strong>For Dev-PoC subscriptions, you do NOT need an approved Governance ID to request a subscription.</strong> </p></td>
</tr>
<tr>
<td data-valign="top"><span><strong>Division</strong></span></td>
<td data-valign="top">Select your Division. <span class="fontColorNeutralDark">Search the User Group in </span><a href="https://lseg.leanix.net/LsegPROD"><span class="fontColorNeutralDark"><u>LeanIX</u></span></a><span class="fontColorNeutralDark"> for your Application ID. </span></td>
</tr>
<tr>
<td data-valign="top"><span><strong>Sub-Division</strong></span></td>
<td data-valign="top">Select your Sub-Division. <span class="fontColorNeutralDark">Search the User Group in </span><a href="https://lseg.leanix.net/LsegPROD"><span class="fontColorNeutralDark"><u>LeanIX</u></span></a><span class="fontColorNeutralDark"> for your Application ID. </span></td>
</tr>
<tr>
<td data-valign="top"><span><strong>Subscription Name</strong></span><br />
<span><strong>Subscription ID</strong></span></td>
<td data-valign="top"><span>Enter the subscription name and ID on which you are attempting to get onboarded.</span></td>
</tr>
<tr>
<td data-valign="top"><span><strong>Resource Group Prefix</strong></span></td>
<td data-valign="top"><p>Enter an abbreviated version of the Application Name.</p>
<ul>
<li><strong>Must include 7-10 characters. </strong></li>
<li><strong>Only use lowercase characters.</strong></li>
<li><strong>Do not use any space or special characters.</strong></li>
</ul>
<p>This will form part of the Resource Group name.</p></td>
</tr>
<tr>
<td data-valign="top"><span><strong>Network Segment</strong></span><br />
<span><strong>Regions</strong></span></td>
<td data-valign="top">Please choose the Network Segment and Azure Region that will be used for the Resource Group. Please note that you can only have a Subscription in a single segment, if a different segment to the one used in the subscription selected, you will need to request a new subscription.<br />
Please refer to this document to see the available regions at this time: <a href="/sites/CloudCentral/SitePages/LMP-Azure-Regions.aspx"><u>LMP Azure Regions (sharepoint.com)</u></a></td>
</tr>
<tr>
<td data-valign="top"><span><strong>Cost Centre</strong></span></td>
<td data-valign="top">Select the cost-centre which will be charged for all cloud costs incurred in the account. If you don't know what your cost-centre is, reach out to your Line Manager.</td>
</tr>
<tr>
<td data-valign="top"><span><strong>Project Code</strong></span></td>
<td data-valign="top"><p>Please enter Clarity project code<br />
<br />
<strong>mnd-projectcode: nnnnn-nnn </strong><br />
If the mnd-projectcode is not yet available, please use "<strong>tobeconfirmed</strong>". </p>
<p>Click here for more detail on <a href="/sites/CloudCentral/SitePages/Considerations-when-planning-a-cloud-dean-application-to-go-to-the-cloud.aspx#projectcode-tag" data-interception="off" target="_blank" rel="noopener noreferrer"><u>Project code</u></a>. </p></td>
</tr>
<tr>
<td data-valign="top"><span><strong>Resource Group Owner DL</strong></span></td>
<td data-valign="top">Email address for the team (DL) owning the Resource Group. Any future onboardings and access requests will request approval to this contact/group.<br />
If you don't have one, you can create one in this link: <a href="/sites/Technology-Support/SitePages/how-to-create-a-distribution-group.aspx">Creating or deleting email distribution lists (sharepoint.com)</a></td>
</tr>
<tr>
<td data-valign="top"><strong>Will your application have public facing resources?</strong></td>
<td data-valign="top">Yes or No</td>
</tr>
<tr>
<td data-valign="top"><span><strong>Support Group</strong></span></td>
<td data-valign="top"><p>Enter the main ServiceNow support group who will own and support this app. </p>
<p>If you don't have one you can create one: <a href="https://lseg.service-now.com/esc?id=sc_cat_item&amp;table=sc_cat_item&amp;sys_id=deed927a1b45c1106bba7ea5464bcba7"><u>Group Management Request (service-now.com)</u></a></p></td>
</tr>
<tr>
<td data-valign="top"><span><strong>Data Classification</strong></span></td>
<td data-valign="top"><p>Approved values taken from</p>
<ul>
<li><strong>Highly Restricted</strong></li>
<li><strong>Restricted</strong></li>
<li><strong>Corporate</strong></li>
<li><strong>Public</strong> </li>
</ul>
<p>Refer to the <a href="/sites/ats/Shared%20Documents/Forms/AllItems.aspx?id=/sites/ats/Shared%20Documents/Standards/LSEG%20Standards/Information%20Security/Approved/LSEG%20Cyber%20Security%20Standard%20-%20Information%20Classification%20and%20Handling%20%28v1.0%29.pdf&amp;parent=/sites/ats/Shared%20Documents/Standards/LSEG%20Standards/Information%20Security/Approved" data-interception="off" target="_blank" rel="noopener noreferrer"><u>Cyber Security standards</u></a> for more info</p></td>
</tr>
</tbody>
</table>

## Approvals and Fulfillment ✅

Once the Application Team submits the ServiceNow form, the approvals will be requested in the following order:

- Primary Application Owner (Owner from Primary/Parent App in the subscription)
- Additional Application owner (Owner of the App looking to be onboarded)
- SRE (to Review Governance ID approval)

Until the approvals are complete, the Engineering team will not complete the request. If the request is rejected, the RITM (Request Item) will be closed incomplete.

  
Once Approved, the Engineer will run the Application Onboarding pipelines. Upon completion, the Engineer will update the request with the details and the following will be created for the application teams:

- Application Resource Group
- Platform and Application AD groups and role assignments
- Application Service principal (SPN)
- DXOne onboarding of the subscription and Service Principal in the existing application project.

ServiceNow will also create a relationship between the Application Configuration Item (CI) and the Subscription CI (in SNOW the table is called ‘Cloud Service Account’).

## What's Next? 🚀

While you wait to receive your onboarding details, please read these important guides to help you in your Azure journey ☁

- Please read how to get access to the subscription: [<u>LMP Azure - How to request access to an Azure Subscription(Strategic solution) (sharepoint.com)</u>](/sites/CloudCentral/SitePages/Subscription.aspx)

- User can then request On-Prem’s connectivity: [<u>LMP Azure Networking Requests</u>](/sites/CloudCentral/SitePages/LMP-Azure-Networking.aspx#connectivity-management)

- Please review the [<u>Cloud Product Framework (sharepoint.com)</u>](/sites/CloudCentral/SitePages/LMP-Azure-CPF.aspx) for more information about using Cloud Products

- Please read important information about Golden Images: [<u>LMP Azure - Golden Images (sharepoint.com)</u>](/sites/CloudCentral/SitePages/LMP-Azure-Golden-Images.aspx)

- Please read our Approval guides for Access Packages and PIM: [<u>Approving Access Packages and Privileged Identity Management Requests (sharepoint.com)</u>](/sites/CloudCentral/SitePages/How-to-Approve-Access-Packages-and-PIM-Requests.aspx)

- If you want to know about the Regions available in LMP Azure, please check: [<u>LMP Azure Regions (sharepoint.com)</u>](/sites/CloudCentral/SitePages/LMP-Azure-Regions.aspx)

Useful LinksAzure - How to request an Azure subscriptionAzure - How to request a -C account for accessing Privileged rolesAzure - Requesting additional Resource Groups for onboarded appsRequesting an additional Region for an existing subscriptionAzure Foundation Subscription Types<a href="/sites/CloudCentral" data-sp-prop-name="baseUrl"></a><a href="/sites/CloudCentral/SitePages/LMP-Azure-Subscription-Vending.aspx" data-sp-prop-name="items[0].sourceItem.url"></a><a href="/sites/CloudCentral/SitePages/LMP-Azure-Requesting-a-%27-C%27-account.aspx" data-sp-prop-name="items[1].sourceItem.url"></a><a href="/sites/CloudCentral/SitePages/LMP-Azure-Requesting-Additional-Resource-Group-Existing-App.aspx" data-sp-prop-name="items[2].sourceItem.url"></a><a href="/sites/CloudCentral/SitePages/Requesting-an-additional-region-for-an-existing-subscription.aspx" data-sp-prop-name="items[3].sourceItem.url"></a><a href="/sites/CloudCentral/SitePages/LMP-Azure-Subscription-Types.aspx" data-sp-prop-name="items[4].sourceItem.url"></a>Have a question? Ask us on StackAsk the Cloud SRE community in Stack OverflowFind what you are looking for? Please provide feedback<a href="/sites/CloudCentral" data-sp-prop-name="baseUrl"></a><a href="https://lseg.stackenterprise.co/communities/104" data-sp-prop-name="items[0].sourceItem.url"></a><a href="https://forms.microsoft.com/Pages/ResponsePage.aspx?id=Dp9-KOyR8Ey3pMY4mAchgYp9CRjyYppFsaTYdwLXKwtUOEg0RUE0MUdFTUJBUzdLV1NKQTVJQVA4Qy4u" data-sp-prop-name="items[1].sourceItem.url"></a>
