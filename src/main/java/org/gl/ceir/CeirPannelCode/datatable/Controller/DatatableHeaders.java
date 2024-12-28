package org.gl.ceir.CeirPannelCode.datatable.Controller;

import java.util.*;

import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableHeaderModel;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DatatableHeaders {
    private final Logger log = LoggerFactory.getLogger(getClass());
    @Autowired
    Translator translator;

    @PostMapping("headers")
    public ResponseEntity<?> headers(@RequestParam(name = "type", defaultValue = "stock", required = false) String role,
                                     @RequestParam(name = "action", required = false) String Operation,
                                     @RequestParam(name = "requestType", required = false) String requestType) {
        List<DatatableHeaderModel> dataTableInputs = new ArrayList<>();
        try {

            // CONSIGNMENT DATATABLE HEADERS
            if ("consignment".equals(role)) {
                String[] headers = {"table.creationDate", "table.transactionID", "table.suppliername", "table.status", "table.taxPaidStatus", "input.quantity", "input.deviceQty", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //STOLEN DATATABLE HEADERS
            else if ("stolen".equals(role)) {
                String[] headers = {"table.date", "table.transactionID", "table.fileName", "table.status", "table.source", "table.requestType", "table.quantity", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //CUSTOM DATATABLE HEADERS
            else if ("customConsignment".equals(role)) {
                String[] headers = {"table.creationDate", "table.transactionID", "table.importerCompanyName", "table.status", "table.taxPaidStatus", "input.quantity", "input.deviceQty", "table.action"};
                for (String header : headers) {
                    log.info("translator.toLocale(header)----" + translator.toLocale(header));
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //Admin DATATABLE HEADERS
            else if ("adminConsignment".equals(role)) {
                String[] headers = {"table.creationDate", "table.transactionID", "table.importerCompanyName", "table.status", "table.taxPaidStatus", "input.quantity", "input.deviceQty", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //consignments from stolen headers
            else if ("stolenconsignment".equals(role)) {
                String[] headers = {"table.blankheader", "table.requestdate", "table.status", "table.suppliername", "table.consignmentStatus", "table.taxPaidStatus", "table.quantity"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //stock headers
            else if ("stockcheckHeaders".equals(role)) {
                String[] headers = {"table.blankheader", "table.requestdate", "table.transactionID", "table.fileName", "table.status", "table.quantity"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //stockHeaders
            else if ("stockHeaders".equals(role)) {

                String[] headers = {"table.creationDate", "table.transactionID", "table.fileName", "table.status", "input.quantity", "input.devicequantity", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //customStock Headers
            else if ("customStockHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.assignto", "table.transactionID", "table.fileName", "table.status", "input.quantity", "input.devicequantity", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //AdminStock Headers
            else if ("adminStockHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.transactionID", "table.importerCompanyName", "table.roleType", "table.fileName", "table.status", "input.quantity", "input.devicequantity", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //stolen headers
            else if ("stolenCheckHeaders".equals(role)) {
                String[] headers = {"table.blankheader", "table.requestdate", "table.transactionID", "table.fileName", "table.status", "table.source", "table.requestType"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //Grievance Headers
            else if ("grievanceHeaders".equals(role)) {

                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.transactionID", "table.grievanceID", "table.status", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //AdminRegistration Headers
            else if ("adminRegistration".equals(role)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.UserName", "table.email", "table.phone", "table.AsType", "table.userType", "table.status", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //DashBoard dataTable Headers
            else if ("dashboardNotification".equals(role)) {
                String[] headers = {"table.date", "table.transactionID", "table.feature", "table.message", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //TRC Manage Type dataTable Headers
            else if ("trcManageType".equals(role)) {
                String[] headers = {"table.creationDate", "table.transactionID", "table.requestdate", "table.ManufacturerName", "table.country", "table.TAC", "table.status", "table.Approve/RejectionDate", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //DEFAULT PORTION
            else if ("userPaidStatus".equals(role)) {
                String[] headers = {"table.creationDate", "table.nid", "table.transactionID", "input.Nationality", "table.taxPaidStatus", "table.origin", "table.status", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //operator view
            else if ("greyBlackList".equals(role)) {
                String[] headers = {"table.creationDate", "table.fileName", "table.fileType", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //adminUserPaidStatus Headers
            else if ("adminUserPaidStatus".equals(role)) {

                String[] headers = {"table.creationDate", "table.nid", "table.transactionID", "input.Nationality", "table.taxPaidStatus", "table.origin", "table.status", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //adminUserPaidStatus Headers
            else if ("blockUnblock".equals(role)) {
                String[] headers = {"table.creationDate", "table.transactionID", "table.requestType", "input.mode", "table.status", "input.quantity", "input.devicequantity", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //adminSystemMessage Headers
            else if ("adminSystemMessage".equals(role)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.feature", "table.subject", "table.Description", "table.Value", "table.Channel", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //adminConfigMessage Headers

            else if ("adminConfigMessage".equals(role)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.moduleName", "table.Description", "table.Value", "table.Type", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            } else if ("checkIMEIConfigMessage".equals(role)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.moduleName", "registration.tag", "table.Description", "table.Value", "nf.msgLang", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            } else if ("checkIMEIContent".equals(role)) {
                String[] headers = {"table.creationDate", "table.moduleName", "table.label", "table.english_name", "table.khmer_name", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //adminPolicyManagement Headers

            else if ("adminPolicyManagement".equals(role)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.Description", "table.Value", "table.Type", "table.Period", "table.status", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //AdmintrcManageType Headers

            else if ("AdmintrcManageType".equals(role)) {
                String[] headers = {"table.creationDate", "table.transactionID", "table.requestdate", "table.ManufacturerName", "table.country", "table.TAC", "table.status", "table.Approve/RejectionDate", "table.CEIRAdminStatus", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

//BlockUnblockCEIRAdmin Headers 


            else if ("BlockUnblockCEIRAdmin".equals(role)) {
                String[] headers = {"table.creationDate", "table.transactionID", "table.Operator", "table.requestType", "table.Mode", "table.status", "input.quantity", "input.devicequantity", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


//lawfulStolenHeaders Headers 

            else if ("lawfulStolenHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.transactionID", "table.BlockType", "table.requestType", "table.Mode", "table.status", "input.quantity", "input.devicequantity", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }
//auditManagement Headers 

            else if ("auditManagement".equals(role)) {
                //String[] headers = {"table.creationDate","table.transactionID","table.UserName","table.userType","table.roleType","table.feature","table.SubFeature","table.action"};
                String[] headers = {"table.creationDate", "table.transactionID", "auditMgmt.UserName", "table.feature", "table.SubFeature", "table.publicIp", "table.browser", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);

            } else if ("moduleAuditTrailHeader".equals(role)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "Module Name", "Feature Name", "Execution Time", "Count", "Count2", "Failure Count", "Status", "Info", "table.action", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }
//ManageUserType Headers 

            else if ("ManageUserType".equals(role)) {
                String[] headers = {"table.RegisterDate", "table.transactionID", "input.nidInput", "table.Nationality", "table.LocalContactNumber", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }
            //ManageUserType Headers

            else if ("ImporterTrcManageType".equals(role)) {
                String[] headers = {"table.creationDate", "table.Trademark", "table.transactionID", "table.TAC", "table.ProductName", "table.ModelNumber", "table.country", "table.status", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //deviceActivation Headers

            else if ("deviceActivation".equals(role)) {
                String[] headers = {"table.RegisterDate", "table.transactionID", "table.PassportNumber", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //AdminImprtertrcManageType Headers

            else if ("AdminImportertrcManageType".equals(role)) {
                //		String[] headers = {"table.creationDate","table.lastupdatedate","table.transactionID","table.displayName","table.TAC","table.ProductName","table.ModelNumber","table.country","table.userType","table.status","table.action"};
                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.transactionID", "table.displayName", "table.TAC", "table.ProductName", "table.ModelNumber", "table.country", "table.userType", "table.status", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //AssigneeStock

            else if ("AssigneeStock".equals(role)) {
                String[] headers = {"tabel.Assignee", "tabel.AssigneeName", "table.Contact", "table.email", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


//fieldManagement

            else if ("fieldManagement".equals(role) && "viewAll".equals(Operation)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "tabel.field", "table.displayName", "tabel.fieldId", "table.Description"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            } else if ("fieldManagement".equals(role) && "filter".equals(Operation)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "tabel.field", "table.displayName", "tabel.fieldId", "table.Description", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //Port Management

            else if ("portManagement".equals(role)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.address", "table.port", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //Currency Management

            else if ("currencyHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.month", "table.year", "table.currency", "table.cambodian", "table.doller", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //customer Care DashBoard dataTable Headers
            else if ("ccdashboardNotification".equals(role)) {
                String[] headers = {"table.date", "table.transactionID", "table.feature", "table.message", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //user Management

            else if ("userManagementHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.userType", "table.status", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //user Feature Management

            else if ("userFeatureHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.userType", "table.feature", "table.period", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

//Rule List

            else if ("ruleList".equals(role)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.name", "table.Description", "table.status", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

//Rule feature Mapping

            else if ("ruleFeatureMapping".equals(role)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.ruleName", "table.featureName", "table.order", "table.gracePeriod", "table.postGracePeriod", "table.moveToGracePeriod", "rule.feature.moveToPostGracePeriod", "table.expectedOutput", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //alert Management

            else if ("alertManagementHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.alertId", "table.moduleName", "table.Description", "table.action"};
                //String[] headers = {"table.creationDate","table.lastupdatedate","table.alertId","table.moduleName","table.Description"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //Running alert Management

            else if ("runningAlertManagementHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.alertId", "table.moduleName", "table.Description", "table.status"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //IP Log Management

            else if ("ipLogManagementHeaders".equals(role)) {
                //String[] headers = {"table.creationDate","table.UserName","table.publicIp","table.browser","table.userAgent"};
                String[] headers = {"table.creationDate", "table.UserName", "table.publicIp", "table.browser"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //Pending TAC List
            else if ("pendingTACHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.transactionID", "table.TAC", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //Grievance Admin Headers
            else if ("adminGrievanceHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.transactionID", "table.grievanceID", "table.UserName", "table.raisedBy", "table.userType", "table.status", "table.action"};
                //String[] headers = {"table.creationDate","table.lastupdatedate","table.transactionID","table.grievanceID","table.UserName","table.userType","table.raisedBy","table.status","table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //SLA Table List

            else if ("slaTableHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.UserName", "table.transactionID", "table.userType", "table.featureName", "table.status"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }


            //User Management

            else if ("userTableHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.UserName", "table.email", "table.phone", "table.userType", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //Visa Headers
            else if ("adminVisaHeaders".equals(role)) {

                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.transactionID", "table.PassportNumber", "table.visaType", "input.VisaNumber", "table.fileName", "table.visaExpiry", "table.status", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //Address Mgmt Headers
            else if ("systemAddressHeaders".equals(role)) {

                String[] headers = {"Created On", "Modified On", "Province", "District", "Commune", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //Schedule Headers
            else if ("scheduleHeaders".equals(role)) {

                String[] headers = {"table.creationDate", "table.lastupdatedate", "sidebar.ReportCatagory", "table.ReportName", "input.email", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            } else if ("deviceManagementHeaders".equals(role) && "multiedit".equals(requestType)) {
                String[] headers = {"table.device.creationDate", "table.device.modificationDate", "input.TAC", "table.devicetype", "table.ProductName", "Marketing Name", "registration.modelname", "select.stockStatus", "<label class='checkbox-container'>" + translator.toLocale("table.selectAll") + "<input type='checkbox' id='selectAllCheckbox' onchange='selectAllCheckbox()'><span class='checkmark'></span></label>"};
                log.info("headers when requestType is " + requestType);
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //Device Management
            else if ("deviceManagementHeaders".equals(role)) {
                String[] headers = {"table.device.creationDate", "table.device.modificationDate", "input.TAC", "table.devicetype", "table.ProductName", "Marketing Name", "registration.modelname", "select.stockStatus", "table.action"};
                log.info("headers when requestType is " + requestType);
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            } else if ("deviceHistoryHeaders".equals(role)) {
                String[] headers = {"table.device.creationDate", "table.device.modificationDate", "input.TAC", "table.devicetype", "table.ProductName", "Marketing Name", "registration.modelname", "select.stockStatus", "Agent Name", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }
            //VIP LIST
            else if ("vipListHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.imei", "table.imsi", "table.msisdn", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }
            //VIP LIST
            else if ("blackListHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.imei", "table.imsi", "table.msisdn", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }
            //VIP LIST
            else if ("greyListHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.imei", "table.imsi", "table.msisdn", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }
            //AllowedTAC
            else if ("allowedTACHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.tac", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }
            //BlockedTAC
            else if ("blockedTACHeaders".equals(role)) {
                String[] headers = {"table.creationDate", "table.tac", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }
            //dump file data
            else if ("dumpDataHeaders".equals(role)) {

                String[] headers = {"table.creationDate", "table.lastupdatedate", "table.fileName", "table.filePath", "table.operatorName", "table.recordCount", "table.fileCopyInterp", "table.fileTypeInterp", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            } else if ("msisdn".equals(role)) {
                String[] headers = {"Created On", "Modified On", "Operator Name", "User ID", "Series Type", "Series Start", "Series End", "Action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            } else if ("trc".equals(role)) {
                String[] headers;
                if (requestType.equals("NA")) {
                    headers = new String[]{"Model Name", "Manufacturer", "Manufacturing Country", "OS", "Launch Date", "Device Type", "Sim Slot", "TAC", "Action"};
                    for (String header : headers) {
                        dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                    }
                } else if (requestType.equals("APPROVED")) {
                    headers = new String[]{"Model Name", "Manufacturer", "Manufacturing Country", "OS", "Launch Date", "Device Type", "Sim Slot", "TAC"};
                    for (String header : headers) {
                        dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                    }
                }

                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //ApprovedDeviceHeaders Headers
            else if ("ApprovedDeviceHeaders".equals(role)) {
                String[] headers = {"Updated Date", "File Name", "Status", "Transaction ID", "Uploaded By", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }
            //viewApprovedDeviceHeaders Headers
            else if ("viewApprovedDeviceHeaders".equals(role)) {
                String[] headers = {"Approved Date", "Company", "Company ID", "Trademark", "Product Name", "Commercial Name", "Model", "Country Of Manufacture", "TRC Identifier"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }
            //viewLocalManufactureHeaders
            else if ("viewLocalManufactureHeaders".equals(role)) {
                String[] headers = {"Uploaded Date", "Serial Number", "IMEI", "Manufacture ID", "Manufacture Name"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }

            //viewQualifiedAgentHeaders
            else if ("viewQualifiedAgentHeaders".equals(role)) {
                String[] headers = {"S.No", "Company Name", "Company ID", "Phone Number", "Email", "Expiry"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            } else if ("eirsListMgmt".equals(role)) {
                String[] headers = {"el.date", "table.transactionID", "table.Mode", "table.status", "table.requestType", "el.category", "el.uploadedby", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            } else if ("exceptionList".equals(role) || "blockList".equals(role) || "grayList".equals(role)) {
                String[] headers = {"el.date", "el.imei", "el.msisdn", "el.imsi", "el.txn", "el.category", "el.uploadedby", "el.source"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            } else if ("block-tac-list-mgmt".equals(role)) {
                String[] headers = {"el.date", "el.tac", "el.txn", "el.category", "el.uploadedby"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            } else if ("duplicateDeviceHeaders".equals(role)) {
                String[] headers = {"Detection Date", "IMEI", "Phone Number", "Ticket ID", "Updated By", "Status", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            } else if ("notification".equals(role)) {
                String[] headers = {"nf.creationDate", "nf.channelType", "nf.featureName", "nf.featureTxn", "nf.msgLang", "nf.subject", "nf.status", "nf.notificationSentTime", "nf.msisdn", "nf.email", "nf.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }
            //stolenImeiStatusCheckHeaders for stolen status check IMEI
            else if ("stolenImeiStatusCheckHeaders".equals(role)) {
                String[] headers = {"nf.creationDate", "ir.updatedDate", "ir.txnId", "ir.RequestMode", "ir.imei", "ir.fileName", "ir.recordCount", "ir.imeiFoundCount", "ir.status", "nf.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            } else if ("trackLostDeviceHeaders".equals(role)) {
                //String[] headers = {"Date & Time","Request Number", "IMEI", "MSISDN", "Operator", "Status","table.action"};
                String[] headers = {"stolen.table.date-time", "stolen.table.req-number", "stolen.table.IMSI", "stolen.table.IMEI", "stolen.table.MSISDN", "stolen.table.operator", "stolen.table.request-type", "stolen.table.status", "table.action"};
                //String[] headers = {"stolen.table.date-time","stolen.table.req-number","stolen.table.IMEI", "stolen.table.MSISDN","stolen.table.operator", "stolen.table.status","table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            } else if ("policeTrackLostDeviceHeaders".equals(role)) {
                //String[] headers = {"Date & Time","Request Number", "IMEI", "Uploaded By","Request Mode","Request Type", "Province", "District", "Commune","Device Type","Status","table.action"};
                String[] headers = {"stolen.table.date-time", "stolen.table.req-number", "stolen.table.IMEI", "stolen.table.UploadedBy", "stolen.table.RequestMode", "stolen.table.request-type", "stolen.table.Province", "stolen.table.District", "stolen.table.Commune", "stolen.table.DeviceType", "stolen.table.status", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            } else if ("policeStationDetailsHeaders".equals(role)) {
                String[] headers = {"Province", "District", "Commune", "Police Station", "Name", "Contact Number"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            } else if ("eirsResponseParam".equals(role)) {
                String[] headers = {
                        "Modified On", "Description",
                        "Value", "Feature Name",
                        "Language", "Action"
                };

                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }
            /*else if ("blockList".equals(role)) {
                String[] headers = {"el.date", "el.imei", "el.msisdn", "el.imsi", "el.txn", "el.category", "el.uploadedby"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
            }*/
            //DEFAULT PORTION
            else {
                String[] headers = {"table.date", "table.transactionID", "table.fileName", "table.status", "table.action"};
                for (String header : headers) {
                    dataTableInputs.add(new DatatableHeaderModel(translator.toLocale(header)));
                }
                return new ResponseEntity<>(dataTableInputs, HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(Collections.emptyList(), HttpStatus.UNAVAILABLE_FOR_LEGAL_REASONS);
        }
    }

/*    public ResponseEntity<List<DatatableHeaderModel>> headers(String[] headers) {
        int i = 0;
        List<DatatableHeaderModel> dataTableHeaders = new ArrayList<>();
        Map<Integer, String> keyOrder = new TreeMap<>();
        for (String header : headers) {
            keyOrder.put(i++, header);
            dataTableHeaders.add(new DatatableHeaderModel(translator.toLocale(header), keyOrder));
        }
        return new ResponseEntity<>(dataTableHeaders, HttpStatus.OK);
    }*/
}
