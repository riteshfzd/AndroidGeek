/** 
Please note that this unit test is only for the coverage purpose of a class created from WSDL.
There should be a proper test with mock interface
*/
@isTest
private class TestAsyncVeraClasses {
   
    private class WebServiceMockImplAsync implements WebServiceMock
    {
        public void doInvoke(
            Object stub, Object request, Map<String, Object> response,
            String endpoint, String soapAction, String requestName,
            String responseNS, String responseName, String responseType)
        {
            if(request instanceof AsyncDeB2bCniCrmPpiSfdcGenesisSchemaC.CreateProposalResponse_elementFuture)
                response.put('response_x', new AsyncDeB2bCniCrmPpiSfdcGenesisSchemaC.CreateProposalResponse_elementFuture());
            else if(request instanceof AsyncDeB2bCniCrmPpiSfdcGenesisSchemaC.ContactUpdateResponse_elementFuture)
                response.put('response_x', new AsyncDeB2bCniCrmPpiSfdcGenesisSchemaC.ContactUpdateResponse_elementFuture());
            else if(request instanceof AsyncDeB2bCniCrmPpiSfdcGenesisSchemaC.CreditUpdateResponse_elementFuture)
                response.put('response_x', new AsyncDeB2bCniCrmPpiSfdcGenesisSchemaC.CreditUpdateResponse_elementFuture());
            else if(request instanceof AsyncDeB2bCniCrmPpiSfdcGenesisSchemaU.UpdateProposalWorkflowResponse_elementFuture)
                response.put('response_x', new AsyncDeB2bCniCrmPpiSfdcGenesisSchemaU.UpdateProposalWorkflowResponse_elementFuture());
            else if(request instanceof AsyncDeB2bCniCrmPpiSfdcGenesisSchemaV.ValidatePartyForDeletionResponse_elementFuture)
                response.put('response_x', new AsyncDeB2bCniCrmPpiSfdcGenesisSchemaV.ValidatePartyForDeletionResponse_elementFuture());
            else if(request instanceof AsyncDeB2bCniCrmPpiSfdcGenesisSchemaV.ValidateAndDeleteProposalResponse_elementFuture)
                response.put('response_x', new AsyncDeB2bCniCrmPpiSfdcGenesisSchemaV.ValidateAndDeleteProposalResponse_elementFuture());
            else if(request instanceof AsyncDeB2bCniCrmPpiSfdcVeraSchemaVera.CreateContractResponse_elementFuture)
                response.put('response_x', new AsyncDeB2bCniCrmPpiSfdcVeraSchemaVera.CreateContractResponse_elementFuture());
            else if(request instanceof AsyncDeB2bCniCrmPpiSfdcVeraSchemaVera.QueueRespone_elementFuture)
                response.put('response_x', new AsyncDeB2bCniCrmPpiSfdcVeraSchemaVera.QueueRespone_elementFuture());

            return;
        }
    }
    
    static testMethod void testProperties() {
                    
        Test.startTest();
            
            new AsyncDeB2bCniCrmPpiSfdcGenesisSchemaC.CreateProposalResponse_elementFuture();
            new AsyncDeB2bCniCrmPpiSfdcGenesisSchemaC.ContactUpdateResponse_elementFuture();
            new AsyncDeB2bCniCrmPpiSfdcGenesisSchemaC.CreditUpdateResponse_elementFuture();
            new AsyncDeB2bCniCrmPpiSfdcGenesisSchemaU.UpdateProposalWorkflowResponse_elementFuture();
            new AsyncDeB2bCniCrmPpiSfdcGenesisSchemaV.ValidatePartyForDeletionResponse_elementFuture();
            new AsyncDeB2bCniCrmPpiSfdcGenesisSchemaV.ValidateAndDeleteProposalResponse_elementFuture();
            new AsyncDeB2bCniCrmPpiSfdcVeraSchemaVera.CreateContractResponse_elementFuture();
            new AsyncDeB2bCniCrmPpiSfdcVeraSchemaVera.QueueRespone_elementFuture();
            
            //Mock webservice callout
            AsyncTempuriOrgDeB2bCniCrmPpiSfdcservi.AsyncBasicHttpBinding_ITwoWayAsync sfdcPortClass = new AsyncTempuriOrgDeB2bCniCrmPpiSfdcservi.AsyncBasicHttpBinding_ITwoWayAsync();
            System.Test.setMock(WebServiceMock.class, new WebServiceMockImplAsync());
            
            System.Continuation cnt = new System.Continuation(0);
            sfdcPortClass.beginValidatePartyForDeletionOperation(cnt,null,null,null);
            
            sfdcPortClass.beginUpdateProposalWorkflowOperation(cnt,null,null,null,null,null);
            sfdcPortClass.beginVERACreateContractOperation(cnt,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
            sfdcPortClass.beginCreateProposalOperation(cnt,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
            sfdcPortClass.beginValidateAndDeleteProposalOperation(cnt,null,null);
            sfdcPortClass.beginContactUpdateOperation(cnt,null,null,null);
            sfdcPortClass.beginCreditUpdateOperation(cnt,null,null,null,null,null,null,null);
            sfdcPortClass.beginVERAQueueOperation(cnt,null);
            
        Test.stopTest();
    }
}