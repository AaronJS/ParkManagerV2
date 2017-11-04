@IsTest
public class SendMailGlobalDeployCallbackTest {

    public static testmethod void testCreateEmailMessageForSuccess() {
        SendMailGlobalDeployCallback callback = new SendMailGlobalDeployCallback('Example');
        Metadata.DeployResult result = new Metadata.DeployResult();
        result.success = true;
        result.details = new Metadata.DeployDetails();
        Metadata.DeployMessage successMessage = new Metadata.DeployMessage();
        result.details.componentSuccesses = new Metadata.DeployMessage[] {successMessage};
        successMessage.componentType = 'CustomMetadata';
        successMessage.fullName = 'SampleType.SampleName';
        
        callback.createEmailMessageForResult(result);
        // Assert stuff about the message
    }
    
    public static testmethod void testCreateEmailMessageForFailure() {
        SendMailGlobalDeployCallback callback = new SendMailGlobalDeployCallback('Example');
        Metadata.DeployResult result = new Metadata.DeployResult();
        result.success = false;
        result.details = new Metadata.DeployDetails();
        Metadata.DeployMessage failureMessage = new Metadata.DeployMessage();
        result.details.componentFailures = new Metadata.DeployMessage[] {failureMessage};
        failureMessage.componentType = 'CustomMetadata';
        failureMessage.fullName = 'SampleType.SampleName';
        failureMessage.problem = 'What a problem!';
        callback.createEmailMessageForResult(result);
        // Assert stuff about the message
    }
}