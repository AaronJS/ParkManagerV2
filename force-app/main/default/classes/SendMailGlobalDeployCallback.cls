global class SendMailGlobalDeployCallback implements Metadata.DeployCallback {
    
    final String deploymentName;
    
    public SendMailGlobalDeployCallback(String deploymentName) {
        this.deploymentName = deploymentName;
    }
    
    global void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context) {
        
        
        Messaging.sendEmail(new Messaging.Email[] { createEmailMessageForResult(result) });
    }
    
    public Messaging.SingleEmailMessage createEmailMessageForResult(Metadata.DeployResult result) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        String subject = null;
        String body = '\n';           

        if (!result.success) {
            subject = deploymentName + ': Deployment Failed';
            for (Integer i = 0; i < result.details.componentFailures.size(); i++) {
                Metadata.DeployMessage m = result.details.componentFailures.get(i);
                body += '\n \n ----------------------------------';
                body += '\n Failed Metadata type : ' + m.componentType;
                body += '\n Full Name :' + m.fullName;
                body += '\n Error message : ' + m.problem;
            }
        } else {
            subject = deploymentName + ': Deployment Successful.';
            body += '\n \n ***** Successfully Deployed Types ****';
            for (Metadata.DeployMessage m : result.details.componentSuccesses) {
                if(m.fullName != 'package.xml') {
                    body += '\n \n ----------------------------------';
                    body += '\n Metadata type : ' + m.componentType;
                    body += '\n Full Name :' + m.fullName;
                }
            }
        }
        
        mail.setSubject(subject);                
        mail.setPlainTextBody(body);
        mail.setToAddresses(new String[] { UserInfo.getUserEmail() });
        return mail;
    }
}