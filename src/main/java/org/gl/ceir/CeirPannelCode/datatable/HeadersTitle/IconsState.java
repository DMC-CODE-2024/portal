package org.gl.ceir.CeirPannelCode.datatable.HeadersTitle;

import org.gl.ceir.CeirPannelCode.features.GlobalMap;
import org.springframework.web.util.HtmlUtils;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.AddMoreFileModel;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.features.operatorconfiguration.model.IconClass;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.Objects;

@Component
public class IconsState {
    @Autowired
    Translator Translator;
    @Autowired
    FeignCleintImplementation feignCleintImplementation;
    @Autowired
    AddMoreFileModel addMoreFileModel, urlToUpload;
    String projectPath = "default";

    String className = "emptyClass";
    String disableIconClass = "eventNone";
    String emptyURL = "JavaScript:void(0);";
    private final Logger log = LoggerFactory.getLogger(getClass());
    // fa fa icons
    String errorIcon = "\"fa fa-exclamation-circle  error-icon\"";
    String downloadIcon = "\"fa fa-download download-icon\"";
    String viewIcon = "\"fa fa-eye teal-text view-icon\"";
    String editIcon = "\"fa fa-pencil edit-icon\"";
    String deletionIcon = "\"fa fa-trash delete-icon\"";
    String replyIcon = "\"fa fa-reply reply-icon\"";
    String approveIcon = "\"fa fa-check-circle-o approve-icon\"";
    String rejectIcon = "\"fa fa-user-times reject-icon\"";
    String payTaxIcon = "\"fa fa-money pay-tax-icon\"";
    String ListIcon = "\"fa fa-list list-icon\"";
    String plusIcon = "\"fa fa-plus-square download-icon\"";
    String historyIcon = "\"fa fa-history download-icon\"";
    String copyIcon = "\"fa fa-light fa-copy\"";
    // icon title
    String errorIconTitle = null;
    String downloadIconTitle = null;
    String viewIconTitle = null;
    String editIconTitle = null;
    String deleteIconTitle = null;
    String replyIconTitle = null;
    String approveIconTitle = null;
    String rejectIconTitle = null;
    String payTaxIconTitle = null;
    String ListIconTittle = null;
    String plusIconTittle = null;
    String historyTitle = null;
    String CopyTitle = "Copy";

    String disableErrorIcon = "\"fa fa-exclamation-circle error-icon disable\"";
    String disableDownloadIcon = "\"fa fa-download download-icon disable\"";
    String disableViewIcon = "\"fa fa-eye view-icon disable\"";
    String disableEditIcon = "\"fa fa-pencil edit-icon disable\"";
    String disableDeletionIcon = "\"fa fa-trash delete-icon disable\"";
    String disableReplyIcon = "\"fa fa-reply reply-icon disable\"";
    String disableApproveIcon = "\"fa fa-check-circle-o approve-icon disable\"";
    String disableRejectIcon = "\"fa fa-user-times reject-icon disable\"";
    String disablePayTaxIcon = "\"fa fa-money pay-tax-icon disable\"";
    String disableHistoryIcon = "\"fa fa-history download-icon disable\"";
    String defaultTagName = "DEFAULT";

    public String state(String fileName, String txnId, String status, String userStatus) {
        // URL link
        executePostConstruct();
        /*String downloadURL = "./dowloadFiles/actual/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";*/
        //String errorURL = "./dowloadFiles/error/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        String errorURL = "consignmentFileDownload('" + fileName.replace(" ", "%20") + "','error','" + txnId + "','" + defaultTagName + "')";
        String downloadURL = "consignmentFileDownload('" + fileName.replace(" ", "%20") + "','actual','" + txnId + "','" + defaultTagName + "')";
        String viewAction = "viewConsignmentDetails('" + txnId + "')";
        String editAction = "EditConsignmentDetails('" + txnId + "')";
        String deleteAction = "DeleteConsignmentRecord('" + txnId + "')";
        String historyAction = "historyRecord('" + txnId + "')";
        log.info("downloadURL::::::::::::::" + downloadURL);


        // state related Code
        String error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "></i></a>";
        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\" ><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\" ><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        String reply = "<a href=" + emptyURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + replyIconTitle + "></i></a>";


        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        log.info("status is-----" + status);

        if (("0".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
        } else if (("1".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
        } else if (("3".equals(status) || "5".equals(status) || "6".equals(status) || "8".equals(status) || "9".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
        } else if (("4".equals(status) || "7".equals(status) || "10".equals(status)) && "Approved".equals(userStatus)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";

        } else if ("2".equals(status) && "Approved".equals(userStatus)) {
            log.info("status is---2---- @@@@@@@@----------" + status);
            error = "<a onclick=" + errorURL + "><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "></i></a>";
            download = "<a onclick=" + downloadURL + " ><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + "><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + "><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

        } else if ((status != "0" || status != "1" || status != "2" || status != "3" || status != "4" || status != "5" || status != "6" || status != "7" || status != "8" || status != "9" || status != "10" || status == null || status.equals("")) && ("Approved".equals(userStatus))) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
            log.info("status is @@@@@@@@-----is not 2----" + status);
        } else if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";

            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
        }

        String action = error.concat(download).concat(view).concat(edit).concat(delete).concat(history);
        return action;

    }


    public String stockState(String fileName, String txnId, String status, String userStatus) {
        // URL link
        executePostConstruct();
        String emptyURL = "JavaScript:void(0);";
        //String downloadURL = "./Consignment/dowloadFiles/actual/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        String downloadURL = "fileDownload('" + fileName.replace(" ", "%20") + "','actual','" + txnId + "','" + defaultTagName + "')";
        String errorURL = "fileDownload('" + fileName.replace(" ", "%20") + "','error','" + txnId + "','" + defaultTagName + "')";
        //String errorURL = "./Consignment/dowloadFiles/error/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        String viewAction = "viewUploadedStockDetails('" + txnId + "')";
        String editAction = "EditUploadedStockDetails('" + txnId + "')";
        String deleteAction = "DeleteStockRecord('" + txnId + "')";
        String historyAction = "historyRecord('" + txnId + "')";
        // state related Code
        String error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\" ><i class=" + downloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        String reply = "<a href=" + emptyURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + replyIconTitle + "></i></a>";

        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";

        if (("0".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
        } else if (("8".equals(status) || "4".equals(status) || "6".equals(status) || "1".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        } else if ("3".equals(status) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        } else if ("7".equals(status) && "Approved".equals(userStatus)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
        } else if ("2".equals(status) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + "><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            download = "<a onclick=" + downloadURL + " ><i class=" + downloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + "><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + "><i class=" + editIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            reply = "<a href=" + emptyURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + replyIconTitle + "></i></a>";
            history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        } else if ((status != "0" || status != "1" || status != "6" || status != "4" || status != "8" || status != "3" || status != "7" || status == null || status.equals("")) && ("Approved".equals(userStatus))) {
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

        }


        if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        }
        String action = error.concat(download).concat(view).concat(edit).concat(delete).concat(history);
        return action;
    }


    public String ImporterStockState(String fileName, String txnId, String status, String userStatus, String assignerId, String userId) {
        // URL link
        executePostConstruct();
        String emptyURL = "JavaScript:void(0);";
        //String downloadURL = "./Consignment/dowloadFiles/actual/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        String downloadURL = "fileDownload('" + fileName.replace(" ", "%20") + "','actual','" + txnId + "','" + defaultTagName + "')";
        String errorURL = "fileDownload('" + fileName.replace(" ", "%20") + "','error','" + txnId + "','" + defaultTagName + "')";
        //String errorURL = "./Consignment/dowloadFiles/error/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        String viewAction = "viewUploadedStockDetails('" + txnId + "')";
        String editAction = "EditUploadedStockDetails('" + txnId + "')";
        String deleteAction = "DeleteStockRecord('" + txnId + "')";
        String historyAction = "historyRecord('" + txnId + "')";
        // state related Code
        String error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\" ><i class=" + downloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        String reply = "<a href=" + emptyURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + replyIconTitle + "></i></a>";

        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";

        if (("0".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
        } else if (("8".equals(status) || "4".equals(status) || "6".equals(status) || "1".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        } else if ("3".equals(status) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        } else if ("7".equals(status) && "Approved".equals(userStatus)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
        } else if ("2".equals(status) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + "><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            download = "<a onclick=" + downloadURL + " ><i class=" + downloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + "><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + "><i class=" + editIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            reply = "<a href=" + emptyURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + replyIconTitle + "></i></a>";
            history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        } else if ((status != "0" || status != "1" || status != "6" || status != "4" || status != "8" || status != "3" || status != "7" || status == null || status.equals("")) && ("Approved".equals(userStatus))) {
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

        }

        log.info("userId-->" + userId + " ||||||||||| " + "assignerId--->" + assignerId);
        if (!userId.equals(assignerId)) {
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

        }

        if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        }
        String action = error.concat(download).concat(view).concat(edit).concat(delete).concat(history);
        return action;
    }

    public String DistributerRetailerIcons(String fileName, String txnId, String status, String userStatus, String assignerId, String userId) {
        // URL link
        executePostConstruct();
        String emptyURL = "JavaScript:void(0);";
        //String downloadURL = "./Consignment/dowloadFiles/actual/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        String downloadURL = "fileDownload('" + fileName.replace(" ", "%20") + "','actual','" + txnId + "','" + defaultTagName + "')";
        String errorURL = "fileDownload('" + fileName.replace(" ", "%20") + "','error','" + txnId + "','" + defaultTagName + "')";
        //String errorURL = "./Consignment/dowloadFiles/error/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        String viewAction = "viewUploadedStockDetails('" + txnId + "')";
        String editAction = "EditUploadedStockDetails('" + txnId + "')";
        String deleteAction = "DeleteStockRecord('" + txnId + "')";
        String historyAction = "historyRecord('" + txnId + "')";
        // state related Code
        String error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        String reply = "<a href=" + emptyURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + replyIconTitle + "></i></a>";

        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";

        if (("0".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
        } else if (("8".equals(status) || "4".equals(status) || "6".equals(status) || "1".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        } else if ("3".equals(status) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        } else if ("7".equals(status) && "Approved".equals(userStatus)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
        } else if ("2".equals(status) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + "><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            download = "<a onclick=" + downloadURL + " ><i class=" + downloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + "><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + "><i class=" + editIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            reply = "<a href=" + emptyURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + replyIconTitle + "></i></a>";
            history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        } else if ((status != "0" || status != "1" || status != "6" || status != "4" || status != "8" || status != "3" || status != "7" || status == null || status.equals("")) && ("Approved".equals(userStatus))) {
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

        }

        //log.info("userId-->" +userId+" ||||||||||| "+"assignerId--->"+assignerId);
        if (!userId.equals(assignerId)) {
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

        }


        if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);

            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        }
        String action = error.concat(download).concat(view).concat(edit).concat(delete).concat(history);
        return action;
    }


    /********************************** Icons for custom Stock  **********************************/

    public String customStockState(String fileName, String txnId, String status, String userStatus) {
        executePostConstruct();
        // URL link
        String emptyURL = "JavaScript:void(0);";
        //String downloadURL = "./Consignment/dowloadFiles/actual/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        String downloadURL = "fileDownload('" + fileName.replace(" ", "%20") + "','actual','" + txnId + "','" + defaultTagName + "')";
        String errorURL = "fileDownload('" + fileName.replace(" ", "%20") + "','error','" + txnId + "','" + defaultTagName + "')";
        //String errorURL = "./Consignment/dowloadFiles/error/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        String viewAction = "viewUploadedStockDetails('" + txnId + "')";
        String editAction = "EditUploadedStockDetails('" + txnId + "')";
        String deleteAction = "DeleteStockRecord('" + txnId + "')";

        // state related Code
        String error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

        String historyAction = "historyRecord('" + txnId + "')";
        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";

        if (("1".equals(status) || "3".equals(status) || "10".equals(status) || "6".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
        } else if ("0".equals(status) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
        } else if ("2".equals(status) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + "><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            download = "<a onclick=" + downloadURL + " ><i class=" + downloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + "><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + "><i class=" + editIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        } else if ("10".equals(status) && "Approved".equals(userStatus)) {
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";

        } else if ("4".equals(status) || "8".equals(status) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

        } else if ("7".equals(status) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";

        } else if ((status != "1" || status != "3" || status != "10" || status != "6" || status != "0" || status != "2" || status != "7" || status != "4" || status != "8" || status == null || status.equals("")) && ("Approved".equals(userStatus))) {
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

        } else if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);

            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        }
        String action = error.concat(download).concat(view).concat(edit).concat(delete).concat(history);
        return action;
    }


    /********************************** Icons for Stolen **********************************/

    public String stolenState(String fileName, String txnId, String status, String userStatus, String requestType, int id, Integer qty) {
        executePostConstruct();
        // URL link
        String file = fileName == null ? null : fileName.replace(" ", "%20");
        String emptyURL = "JavaScript:void(0);";
        String errorURL = "fileDownload('" + file + "','error','" + txnId + "','" + defaultTagName + "')";
        //String errorURL = "./Consignment/dowloadFiles/error/"+file+"/"+txnId+"/"+defaultTagName+"";
        //String downloadURL = "./Consignment/dowloadFiles/actual/"+file+"/"+txnId+"/"+defaultTagName+"";
        String downloadURL = "fileDownload('" + file + "','actual','" + txnId + "','" + defaultTagName + "')";
        String editAction = "openFileStolenUpdate('" + txnId + "','" + requestType + "','" + id + "','" + qty + "')";
        String deleteAction = "DeleteConsignmentRecord('" + txnId + "','" + id + "','" + requestType + "')";


        // state related Code
        String error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";


        if ("0".equals(status) || "2".equals(status) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        } else if ("1".equals(status) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        } else if ("2".equals(status) && "Approved".equals(userStatus)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        } else if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        }

        String action = error.concat(download).concat(edit).concat(delete);
        return action;

    }


    /********************************** Icons for custom **********************************/

    public String customState(String fileName, String txnId, String status, String userStatus, String displayName) {

        // URL link
        // call post construct
        executePostConstruct();
        String emptyURL = "JavaScript:void(0);";
        //String downloadURL = "./dowloadFiles/actual/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        String downloadURL = "fileDownload('" + fileName.replace(" ", "%20") + "','actual','" + txnId + "','" + defaultTagName + "')";
        String viewAction = "viewConsignmentDetails('" + txnId + "')";
        String approveAction = "openApprovePopUp('" + txnId + "')";

        /* String escapedString = queryParser.escape(approveAction); */
        String rejectAction = "openDisapprovePopup('" + txnId + "')";
        String historyAction = "historyRecord('" + txnId + "')";

        // state related Code
        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";

        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        String approve = "<a onclick=" + approveAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + approveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";


        String reject = "<a onclick=" + rejectAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + rejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";

        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        if (("6".equals(status) || "7".equals(status)) && "Approved".equals(userStatus)) {
            approve = "<a onclick=" + approveAction + " class=" + disableIconClass + "><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
        } else if ("5".equals(status) && "Approved".equals(userStatus)) {
            download = "<a onclick=" + downloadURL + " ><i class=" + downloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";

            view = "<a onclick=" + viewAction + "><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

            approve = "<a onclick=" + approveAction + "><i class=" + approveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";


            reject = "<a onclick=" + rejectAction + "><i class=" + rejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";

            history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";

        } else if ((status != "5" || status != "6" || status != "7" || status == null || status.equals("")) && ("Approved".equals(userStatus))) {
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        } else if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";


        }


        String action = download.concat(view).concat(approve).concat(reject).concat(history);
        return action;
    }

    /********************************** Icons for Admin Consignment **********************************/

    public String adminState(String fileName, String txnId, String status, String userStatus, String companyName) {
        executePostConstruct();
        log.info("companyName::::::::::" + companyName);
        // URL link
        String errorURL = "consignmentFileDownload('" + fileName.replace(" ", "%20") + "','error','" + txnId + "','" + defaultTagName + "')";
        String downloadURL = "consignmentFileDownload('" + fileName.replace(" ", "%20") + "','actual','" + txnId + "','" + defaultTagName + "')";
        String viewAction = "viewConsignmentDetails('" + txnId + "')";

        if (companyName == null) {
            companyName = " ";
        }
        /*
         * String approveAction = "openApprovePopUp('" + txnId+
         * "','"+companyName.trim().replaceAll("\\s", "20")+ "')"; //String
         * approveAction = "openApprovePopUp('"+txnId+"')"; String rejectAction =
         * "openDisapprovePopup('"+txnId+"','"+companyName.trim().replaceAll("\\s",
         * "20")+"')";
         */

        String approveAction = "openApprovePopUp('" + txnId + "')";
        //String approveAction = "openApprovePopUp('"+txnId+"')";
        String rejectAction = "openDisapprovePopup('" + txnId + "')";

        String deleteAction = "DeleteConsignmentRecord('" + txnId + "')";
        String historyAction = "historyRecord('" + txnId + "')";
        log.info("companyName::::::::::" + companyName);
        log.info("<><><><>status<><><><><>" + status + "<><><><><>userStatus<><><><><>" + userStatus);


        // state related Code

        String error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "></i></a>";

        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";

        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        String approve = "<a onclick=" + approveAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + approveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";


        String reject = "<a onclick=" + rejectAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + rejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";

        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";


        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";


        //Disable View
        if (("3".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        } else if (("4".equals(status)) && "Approved".equals(userStatus)) {
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        } else if (("0".equals(status) || "6".equals(status) || "7".equals(status) || "8".equals(status) || "9".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
        } else if (("2".equals(status)) && "Approved".equals(userStatus)) {
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
        } else if (("5".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
        }


        String action = error.concat(download).concat(view).concat(approve).concat(reject).concat(delete).concat(history);
        return action;
    }

    /********************************** Icons for Grievance **********************************/

    public String grievanceState(String fileName, String txnId, String grievanceId, String status, String userStatus, int userId) {
        executePostConstruct();
        String replyAction = "grievanceReply('" + userId + "','" + grievanceId + "','" + txnId + "')";
        String viewAction = "viewGrievanceHistory('" + grievanceId + "','" + projectPath + "')";

        // state related Code
        String reply = "<a onclick=" + replyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + replyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        log.info("status is--->" + status + "---userStatus---->" + userStatus);
        //Disable reply
        if (("0".equals(status) || "1".equals(status) || "2".equals(status)) && "Approved".equals(userStatus)) {
            reply = "<a onclick=" + replyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + replyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        } else if ("3".equals(status) && "Approved".equals(userStatus)) {
            reply = "<a onclick=" + replyAction + " class=\"eventNone\"><i class=" + disableReplyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
        } else if ((status != "0" || status != "1" || status != "3" || status == null || status.equals("")) && ("Approved".equals(userStatus))) {
            reply = "<a onclick=" + replyAction + " class=\"eventNone\"><i class=" + disableReplyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        }
        if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            reply = "<a onclick=" + replyAction + " class=\"eventNone\"><i class=" + disableReplyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";


        }


        String action = reply.concat(view);
        return action;
    }


    /********************************** Icons for Custom Grievance **********************************/

    public String customGrievanceState(String fileName, String txnId, String grievanceId, String status, String userStatus, int userId) {
        executePostConstruct();
        String replyAction = "grievanceReply('" + userId + "','" + grievanceId + "','" + txnId + "')";
        String viewAction = "viewGrievanceHistory('" + grievanceId + "')";

        // state related Code
        String reply = "<a onclick=" + replyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + replyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";


        log.info("status is--->" + status + "---userStatus---->" + userStatus);
        //Disable reply
        if (("0".equals(status) || "1".equals(status) || "2".equals(status)) && "Approved".equals(userStatus)) {
            reply = "<a onclick=" + replyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + replyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        } else if ("3".equals(status) && "Approved".equals(userStatus)) {
            reply = "<a onclick=" + replyAction + " class=\"eventNone\"><i class=" + disableReplyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
        } else if ((status != "0" || status != "1" || status != "3" || status == null || status.equals("")) && ("Approved".equals(userStatus))) {
            reply = "<a onclick=" + replyAction + " class=\"eventNone\"><i class=" + disableReplyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        } else if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            reply = "<a onclick=" + replyAction + " class=\"eventNone\"><i class=" + disableReplyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
        }

        String action = reply.concat(view);
        return action;
    }


    /********************************* Icons for Admin Grievance *********************************/

    public String adminGrievanceState(String fileName, String txnId, String grievanceId, String status, String userStatus, int userId) {
        executePostConstruct();
        String replyAction = "grievanceReply('" + userId + "','" + grievanceId + "','" + txnId + "')";
        String viewAction = "viewGrievanceHistory('" + grievanceId + "')";

        // state related Code
        String reply = "<div class='d-flex'><a onclick=" + replyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + replyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a></div>";

        log.info("status is--->" + status + "---userStatus---->" + userStatus);

        if (("0".equals(status) || "1".equals(status) || "2".equals(status)) && "Approved".equals(userStatus)) {
            reply = "<div class='d-flex'><a onclick=" + replyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + replyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a></div>";

        } else if ("3".equals(status) && "Approved".equals(userStatus)) {
            reply = "<div class='d-flex'><a onclick=" + replyAction + " class=\"eventNone\"><i class=" + disableReplyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a></div>";
        } else if (status != "0" || status != "1" || status != "2" || status != "3" || status == null || status.equals("")) {
            reply = "<div class='d-flex'><a onclick=" + replyAction + " class=\"eventNone\"><i class=" + disableReplyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a></div>";
        }

        if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            reply = "<div class='d-flex'><a onclick=" + replyAction + " class=\"eventNone\"><i class=" + disableReplyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a></div>";
        }


        String action = reply.concat(view);
        return action;
    }


    /********************************* Icons for Admin *********************************/

    public String adminStockState(String fileName, String txnId, String status, String userStatus) {
        executePostConstruct();
        // URL link
        String emptyURL = "JavaScript:void(0);";
        String errorURL = "fileDownload('" + fileName.replace(" ", "%20") + "','error','" + txnId + "','" + defaultTagName + "')";
        //String errorURL = "./Consignment/dowloadFiles/error/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        //String downloadURL = "./Consignment/dowloadFiles/actual/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        String downloadURL = "fileDownload('" + fileName.replace(" ", "%20") + "','actual','" + txnId + "','" + defaultTagName + "')";
        String viewAction = "viewUploadedStockDetails('" + txnId + "')";
        String approveAction = "ApproveStock('" + txnId + "')";
        String rejectAction = "disApproveStock('" + txnId + "')";
        String deleteAction = "DeleteStockRecord('" + txnId + "')";
        // state related Code

        String historyAction = "historyRecord('" + txnId + "')";
        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";

        String error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "></i></a>";

        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";


        String approve = "<a onclick=" + approveAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + approveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";


        String reject = "<a onclick=" + rejectAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + rejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";


        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";


        if (("0".equals(status) || "1".equals(status) || "4".equals(status) || "8".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";

        } else if ("7".equals(status)) {
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";

        } else if (("2".equals(status)) && "Approved".equals(userStatus)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";

        } else if (("6".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";

        } else if (("3".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
        } else if (status != "0" || status != "1" || status != "2" || status != "4" || status != "8" || status != "7" || status != "6" || status != "3" || status == null || status.equals("")) {
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";

        } else if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";

        }

        String action = error.concat(download).concat(view).concat(approve).concat(reject).concat(delete).concat(history);
        return action;

    }


    /********************************** Icons for AdminRegistrationRequest **********************************/

    public String adminRegistrationRequest(String Id, String userStatus, String AdminCurrentStatus, String createdOn, String roles, String type, String id, String username, String status, String sessionUserName, String userTypeId, String source) {
        executePostConstruct();
        roles = roles.replace(" ", "%20");
        log.info("username-->" + username + " sessionUserName--->" + sessionUserName + "roles-------->" + roles);
        // URL link
        String emptyURL = "JavaScript:void(0);";
        String approveAction = "userApprovalPopup(" + Id + ",'" + createdOn.replace(" ", "=") + "','" + username + "','" + sessionUserName + "')";
        String viewAction = "chngeView(" + id + ",'" + roles.replace(" ", "=") + "','" + type + "','" + source + "','" + username + "')";
        String rejectAction = "userRejectPopup(" + Id + ",'" + sessionUserName + "','" + username + "')";
        String editAction = "roleStatusChange('" + Id + "','" + sessionUserName + "','" + userTypeId + "'," + id + ",'" + username + "')";
        String historyAction = "historyRecord('" + Id + "','" + roles + "','" + username + "')";

        log.info("status---->" + status + "---------AdminCurrentStatus------>" + AdminCurrentStatus + " userStatus----------->" + userStatus);

        // state related Code


        String view = "<a onclick=" + viewAction + " id='arlink' class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";

        String approve = "<a onclick=" + approveAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + approveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";


        String reject = "<a onclick=" + rejectAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + rejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";

        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";

        if (("0".equals(status) || "1".equals(status)) && "Approved".equals(userStatus)) {
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
        } else if (("3".equals(status)) && "Approved".equals(userStatus)) {
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
        } else if (("4".equals(status)) && "Approved".equals(userStatus)) {
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
        } else if (("5".equals(status) || "6".equals(status)) && "Approved".equals(userStatus)) {
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";

        } else if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);

            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";

        }
        String action = view.concat(edit).concat(approve).concat(reject).concat(history);
        return action;

    }


    /********************************* Icons for DashBoard Notification *********************************/


    public String dashboardIcon(String userStatus, Integer featureID, String txnID, Integer userID, String roleType, String reciverUserType) {
        executePostConstruct();
        // URL link
        String viewAction = featureID == 3 ? "./viewConsignment?source=noti&txnID=" + txnID + "" : featureID == 4 ? "./assignDistributor?txnID=" + txnID + "&userTypeId=" + roleType + "&source=noti" : featureID == 0 ? "./stolenRecovery?txnID=" + txnID + "&source=noti" : featureID == 6 ? "./grievanceManagement?txnID=" + txnID + "&source=noti" : featureID == 7 ? "./stolenRecovery?txnID=" + txnID + "&source=noti" : featureID == 8 ? "./registrationRequest?txnID=" + txnID + "&source=noti" : featureID == 11 ? "./manageTypeDevices?txnID=" + txnID + "&source=noti" : featureID == 12 ? "./uploadPaidStatus?via=other&txnID=" + txnID + "&source=noti" : featureID == 21 ? "./manageTypeDevices2?txnID=" + txnID + "&source=noti" : featureID == 43 ? "./updateVisa?txnID=" + txnID + "&source=noti" : featureID == 5 ? "./stolenRecovery?txnID=" + txnID + "&source=noti&FeatureId=" + featureID : "JavaScript:void(0);";
        // System.out.println("featureID::::::::::"+featureID);
        // state related Code
        String view = null;
        String functionName = "isActive(" + featureID + ")";
        if (featureID == 3 || featureID == 4 || featureID == 6 || featureID == 7 || featureID == 21 || featureID == 43 || featureID == 12 || featureID == 5 || (featureID == 8 && reciverUserType.equalsIgnoreCase("CEIRAdmin"))) {
            view = "<a href=" + viewAction + " onclick=" + functionName + "><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        } else {

            view = "<a href=" + viewAction + " onclick=" + functionName + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        }
        String action = view;
        return action;

    }

    /********************************** Icons for TRC Manage Type Datatable **********************************/


    public String trcManageIcons(String status, Integer id, String fileName, String txnId, String userStatus) {
        // URL link
        //String downloadURL = "JavaScript:void(0)";
        //String downloadURL = "./Consignment/dowloadFiles/actual/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        String downloadURL = "fileDownload('" + fileName.replace(" ", "%20") + "','actual','" + txnId + "','" + defaultTagName + "')";
        String viewAction = "viewByID(" + id + ",'view','" + projectPath + "')";
        String editAction = "viewByID(" + id + ",'edit')";
        // state related Code
        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";

        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";

        if (("0".equals(status)) && "Approved".equals(userStatus)) {
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        } else if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";

        }


        String action = download.concat(view).concat(edit);
        return action;

    }


    /********************************** Icons for UPS **********************************/
    public String userPaidStatusIcon(String imei1, String taxStatus, String status, String userStatus, String txnId, String source) {
        executePostConstruct();
        String payTaxAction = "taxPaid('" + imei1 + "','" + txnId + "')";
        String errorURL = "fileDownload('','error','" + txnId + "','" + defaultTagName + "')";
        String viewAction = "viewDetails('" + imei1 + "','" + txnId + "','" + source + "')";
        String deleteAction = "deleteByImei('" + imei1 + "','" + txnId + "')";


        String historyAction = "historyRecord('" + txnId + "')";
        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";

        log.info("taxStatus-->" + taxStatus + " statusInterp----->" + status);

        String taxPaid = "<a onclick=" + payTaxAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + payTaxIcon + " aria-hidden=\"true\" title=" + payTaxIconTitle + "></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";

        if (("3".equals(status) || "6".equals(status) || "7".equals(status)) && "Approved".equals(userStatus)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
        } else if ("0".equals(status) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";

        } else if ("1".equals(status) && "Approved".equals(userStatus)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            taxPaid = "<a onclick=" + payTaxAction + "  class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disablePayTaxIcon + " aria-hidden=\"true\" title=" + payTaxIconTitle + "></i></a>";
        } else if ("8".equals(status) && "Approved".equals(userStatus)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            taxPaid = "<a onclick=" + payTaxAction + "  class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disablePayTaxIcon + " aria-hidden=\"true\" title=" + payTaxIconTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
        } else if ("2".equals(status) && "Approved".equals(userStatus)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            taxPaid = "<a onclick=" + payTaxAction + "  class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disablePayTaxIcon + " aria-hidden=\"true\" title=" + payTaxIconTitle + "></i></a>";

        } else if ((status != "1" || status != "2" || status != "3" || status != "4" || status != "6" || status != "7" || status != "8" || status == null || status.equals("")) && ("Approved".equals(userStatus))) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            taxPaid = "<a onclick=" + payTaxAction + "  class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disablePayTaxIcon + " aria-hidden=\"true\" title=" + payTaxIconTitle + "></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        }


        if (("0".equals(taxStatus) || "2".equals(taxStatus)) && "Approved".equals(userStatus)) {
            taxPaid = "<a onclick=" + payTaxAction + "  class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disablePayTaxIcon + " aria-hidden=\"true\" title=" + payTaxIconTitle + "></i></a>";
        }


        if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);

            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            taxPaid = "<a onclick=" + payTaxAction + "  class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disablePayTaxIcon + " aria-hidden=\"true\" title=" + payTaxIconTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
        }


        String action = error.concat(taxPaid).concat(view).concat(delete).concat(history);
        return action;
    }


    /********************************** Icons for AdminUPS **********************************/
    public String adminUserPaidStatusIcon(String imei1, String createdOn, String txnId, String State, String userStatus, String source) {
        executePostConstruct();
        String viewAction = "viewDetails('" + imei1 + "','" + txnId + "','" + source + "')";

        String approveAction = "deviceApprovalPopup('" + imei1 + "','" + createdOn.replace(" ", "=") + "','" + txnId + "')";
        String rejectAction = "userRejectPopup('" + imei1 + "','" + txnId + "')";
        String deleteAction = "deleteByImei('" + imei1 + "','" + txnId + "')";

        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String approve = "<a onclick=" + approveAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + approveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
        String reject = "<a onclick=" + rejectAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + rejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";

        log.info("State= " + State + " userStatus= " + userStatus);

        String historyAction = "historyRecord('" + txnId + "')";
        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        if ("6".equals(State) && "Approved".equals(userStatus)) {
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
        } else if ("7".equals(State) && "Approved".equals(userStatus)) {
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
        } else if (("0".equals(State) || "1".equals(State) || "2".equals(State) || "4".equals(State) || "8".equals(State)) && ("Approved".equals(userStatus))) {
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        } else if ("3".equals(State) && "Approved".equals(userStatus)) {
            view = "<a onclick=" + viewAction + "><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            approve = "<a onclick=" + approveAction + "><i class=" + approveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + "><i class=" + rejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + "><i class=" + deletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";

        } else if (State != "0" || State != "1" || State != "2" || State != "3" || State != "4" || State != "6" || State != "7" || State != "8" || State == null || State.equals("")) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        }

        if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        }


        String action = view.concat(approve).concat(reject).concat(delete).concat(history);
        return action;
    }


    /********************************** Icons for Operator **********************************/
    public String greyBlackIcon(String userStatus, String fileName) {
        executePostConstruct();
        //	String downloadURL = "./dowloadFiles/"+fileName.replace(" ", "%20")+"/";
        String downloadurl = "fileDownloadGreyList('" + fileName.replace(" ", "%20") + "')";
        String download = "<a onclick=" + downloadurl + " class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
        log.info("==downloadurl==" + downloadurl);

        /*
         * if("Disable".equals(userStatus)) {
         * log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::"+userStatus);
         *
         * download="<a href="+downloadURL+"  class="+disableIconClass+"><i class="
         * +disableDownloadIcon+" aria-hidden=\"true\" title="
         * +downloadIconTitle+" ></i></a>"; }
         */
        String action = download;
        return action;

    }


    /********************************* Icons for Stolen *********************************/

    public String blockUnblockState(String fileName, String txnId, String status, String userStatus, String requestType, int id, Integer qty, String source) {
        executePostConstruct();
        // URL link
        String file = fileName == null ? null : fileName.replace(" ", "%20");

        String viewAction = "";
        String editAction = "";

        String errorURL = "fileDownload('" + file + "','error','" + txnId + "','" + defaultTagName + "')";
        //String errorURL = "./Consignment/dowloadFiles/error/"+file+"/"+txnId+"/"+defaultTagName+"";
        //String downloadURL = "./Consignment/dowloadFiles/actual/"+file+"/"+txnId+"/"+defaultTagName+"";
        String downloadURL = "fileDownload('" + file + "','actual','" + txnId + "','" + defaultTagName + "')";
        String deleteAction = "DeleteConsignmentRecord('" + txnId + "','" + id + "','" + requestType + "')";
        String historyAction = "historyRecord('" + txnId + "','" + source + "')";

        if (source.equals("3")) {
            editAction = "viewDeviceDetails('" + txnId + "','edit','" + requestType + "')";
            viewAction = "viewDeviceDetails('" + txnId + "','view','" + requestType + "')";
        } else if (source.equals("4")) {
            editAction = "viewblockImeiDevice('" + txnId + "','edit','" + requestType + "')";
            viewAction = "viewblockImeiDevice('" + txnId + "','view','" + requestType + "')";
        }

        // state related Code
        String error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\" title=" + editIconTitle + "></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";

        log.info("source---> " + source + "  status----> " + status);

        if ((status.equals("0")) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        } else if ((status.equals("1") || status.equals("3") || "5".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        } else if ((status.equals("4")) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

        } else if (("7".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        } else if (status.equals("2") && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        } else if ((status != "0" || status != "1" || status != "2" || status != "3" || status != "4" || status != "7" || status == null || status.equals("")) && ("Approved".equals(userStatus))) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        }

        if (source.equals("4")) {
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
        }

        if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";

            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";

            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";

        }


        /*
         * for (ActionModel actionModel : actionResponse) {
         *
         *
         * switch(actionModel.getState()) { case 0: error=disableHandling(actionModel,
         * errorURL); log.info("------------------ case 0"); break; case 1:
         * error=disableHandling(actionModel, errorURL);
         * log.info("------------------ case 1"); break; case 2:
         * error=disableHandling(actionModel, errorURL);
         * log.info("------------------ case 2"); break; case 3:
         * error=enableHandling(actionModel,errorURL);
         * log.info("------------------ case 3"); break; case 4:
         * error=disableHandling(actionModel, errorURL);
         * log.info("------------------ case 4"); break; case 5:
         * error=disableHandling(actionModel, errorURL);
         * log.info("------------------ case 5"); break; } }
         */


        String action = error.concat(download).concat(view).concat(edit).concat(delete).concat(history);
        return action;

    }


    /********************************** Icons for Admin MEssage Management**********************************/

    public String adminMessageIcons(String userStatus, String tag) {
        executePostConstruct();
        String editAction = "updateDetails('" + tag + "')";
        String viewAction = "viewDetails('" + tag + "')";


        // state related Code
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);

            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";

        }

        String action = view.concat(edit);
        return action;

    }


    /********************************** Icons for Check IMEI Management**********************************/

    public String adminConfigIcons(String userStatus, String tag, String type) {
        executePostConstruct();
        String editAction = "updateDetails('" + tag + "')";
        String viewAction = "viewDetails('" + tag + "')";

        // state related Code
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";


        if ("0".equals(type)) {
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        }

        String action = view.concat(edit);
        //String action=view;
        return action;

    }


    /********************************** Icons for Check IMEI Management**********************************/

    public String vipListIcons(String userStatus, String tag, String type) {
        executePostConstruct();
        String editAction = "updateDetails('" + tag + "')";
        String viewAction = "viewDetails('" + tag + "')";

        // state related Code
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";


        if ("0".equals(type)) {
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        }

        //String action=view.concat(edit);
        String action = view;
        return action;

    }

    public String dumpFile(String userStatus, String file, String filePath, String url) {
        executePostConstruct();

        //String downloadURL = "fileDownload('"+file+"','actual','"+filePath+"','"+defaultTagName+"')";
//		String download="<a onclick="+downloadURL+" class=\"waves-effect waves-light modal-trigger\"><i class="
//				+downloadIcon+" aria-hidden=\"true\" title="
//				+downloadIconTitle+" ></i></a>";

        String download = "<a  href='" + url + filePath + file + "' class=\"waves-effect waves-light modal-trigger\" target=\"_blank\"><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";


        String action = download;
        return action;

    }

    public String greyListIcons(String userStatus, String tag, String type) {
        executePostConstruct();
        String editAction = "updateDetails('" + tag + "')";
        String viewAction = "viewDetails('" + tag + "')";

        // state related Code
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";


        if ("0".equals(type)) {
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        }

        //String action=view.concat(edit);
        String action = view;
        return action;

    }

    public String blackListIcons(String userStatus, String tag, String type) {
        executePostConstruct();
        String editAction = "updateDetails('" + tag + "')";
        String viewAction = "viewDetails('" + tag + "')";

        // state related Code
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";


        if ("0".equals(type)) {
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        }

        //String action=view.concat(edit);
        String action = view;
        return action;

    }

    public String allowedBlockedIcons(String userStatus, String tag, String type) {
        executePostConstruct();
        String editAction = "updateDetails('" + tag + "')";
        String viewAction = "viewDetails('" + tag + "')";

        // state related Code
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";


        if ("0".equals(type)) {
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        }

        //String action=view.concat(edit);
        String action = view;
        return action;

    }

    /********************************** Icons for AdminConfig Management**********************************/

    public String checkImeiIcons(String userStatus, String tag, String type) {
        executePostConstruct();
        String editAction = "updateDetails('" + tag + "')";
        String viewAction = "viewDetails('" + tag + "')";

        // state related Code
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
/*


        if ("0".equals(type)) {
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        }
*/

        String action = view.concat(edit);
        //String action=view;
        return action;

    }


    /********************************** Icons for Policy Config Management**********************************/

    public String policyConfigIcons(String userStatus, String tag, String Status, String type) {
        executePostConstruct();
        String editAction = "updateDetails('" + tag + "','" + Status + "')";
        String viewAction = "viewDetails('" + tag + "')";

        // state related Code
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        if ("0".equals(type)) {
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        }
        if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);

            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";

        }

        String action = view.concat(edit);
        return action;

    }


    /********************************** Icons for Admin TRC Manage Type Datatable **********************************/


    public String trcAdminManageIcons(String status, Integer id, String txnId, String userStatus, String fileName) {
        executePostConstruct();

        log.info("fileName in Admin Icon-->" + fileName);
        String errorURL = "fileDownload('" + fileName.replace(" ", "%20") + "','error','" + txnId + "','" + defaultTagName + "')";
        String viewAction = "ImporterviewByID(" + id + ",'view','" + projectPath + "','viewImporterModal')";
        //	String downloadURL = "./dowloadFiles/actual/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        //String downloadURL = "fileDownload('"+fileName.replace(" ", "%20")+"','actual','"+txnId+"','"+defaultTagName+"')";
        String approveAction = "openApproveTACPopUp('" + txnId + "','')";
        String rejectAction = "openDisapproveTACPopUp('" + txnId + "','')";
        String deleteAction = "DeleteTacRecord('" + txnId + "'," + id + ")";

        String error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        String historyAction = "historyRecord('" + txnId + "')";
        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";

        String approve = "<a onclick=" + approveAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + approveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
        String reject = "<a onclick=" + rejectAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + rejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

        if ("6".equals(status)) {
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        } else if ("7".equals(status)) {
            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";

        } else if (("0".equals(status) || "1".equals(status) || "4".equals(status) || "8".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        } else if (("3".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        } else if (("2".equals(status)) && "Approved".equals(userStatus)) {
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        } else if (status != "0" || status != "1" || status != "2" || status != "3" || status != "4" || status != "6" || status != "7" || status != "8" || status == null || status.equals("")) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        }


        String action = error.concat(view).concat(approve).concat(reject).concat(delete).concat(history);
        return action;

    }

    /********************************** Icons for adminBlockUnblock **********************************/

    public String adminBlockUnblock(String fileName, String txnId, String status, String userStatus, String requestType, int id, Integer qty, String source, String operator) {
        String file = fileName == null ? null : fileName.replace(" ", "%20");
        String viewAction = "";
        //String downloadURL = "./Consignment/dowloadFiles/actual/" + file + "/" + txnId +"/"+defaultTagName+ "";
        String downloadURL = "fileDownload('" + file + "','actual','" + txnId + "','" + defaultTagName + "')";
        String approveAction = "deviceApprovalPopup('" + txnId + "','" + requestType + "')";
        String rejectAction = "userRejectPopup('" + txnId + "','" + requestType + "')";
        //	String errorURL = "./Consignment/dowloadFiles/error/"+file+"/"+txnId+"/"+defaultTagName+"";
        String errorURL = "fileDownload('" + file + "','error','" + txnId + "','" + defaultTagName + "')";

        String deleteAction = "DeleteConsignmentRecord('" + txnId + "','" + id + "','" + requestType + "')";


        String historyAction = "historyRecord('" + txnId + "','" + source + "')";
        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        log.info("============actionResponse=======" + status);
        if (source.equals("3")) {
            viewAction = "viewDeviceDetails('" + txnId + "','view','" + requestType + "')";
        } else if (source.equals("4")) {
            viewAction = "viewblockImeiDevice('" + txnId + "','view','" + requestType + "')";
        }

        // state related Code
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
        String approve = "<a onclick=" + approveAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + approveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
        String reject = "<a onclick=" + rejectAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + rejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";

        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";

        String error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";

        log.info("source->" + source + "status-->" + status + " userStatus--->" + userStatus + "  operator-->" + operator);


        if (("0".equals(status) || "1".equals(status) || "6".equals(status) || "7".equals(status) || "5".equals(status) || "4".equals(status)) && "Approved".equals(userStatus)) {
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            log.info("status--------->" + status + "----userStatus----->" + userStatus);

        } else if ("2".equals(status) && "Approved".equals(userStatus)) {
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            log.info("status--------->" + status + "----userStatus----->" + userStatus);

        } else if ("3".equals(status)) {
            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        } else if (status != "0" || status != "1" || status != "2" || status != "3" || status != "4" || status != "5" || status != "6" || status != "7" || status == null || status.equals("")) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        }

        if ("4".equals(source)) {
            download = "<a onclick=" + downloadURL + "  class=\"eventNone\"><i class=" + disableDownloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";

            log.info("source->" + source);

        }


        if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";

        }


        String action = error.concat(download).concat(view).concat(approve).concat(reject).concat(delete).concat(history);
        return action;
    }


    /********************************** Icons for StolenlawfulAgency **********************************/

    public String StolenlawfulAgency(String fileName, String txnId, String status, String userStatus, String requestType, int id, Integer qty, String source, String requestTypeValue, String requestSource) {
        executePostConstruct();
        // URL link
        String file = fileName == null ? null : fileName.replace(" ", "%20");

        String viewAction = "";
        String editAction = "";
        String emptyURL = "JavaScript:void(0);";
        //	String errorURL = "./Consignment/dowloadFiles/error/"+file+"/"+txnId+"/"+defaultTagName+"";
        String errorURL = "fileDownload('" + file + "','error','" + txnId + "','" + defaultTagName + "')";
        //String downloadURL = "./Consignment/dowloadFiles/actual/"+file+"/"+txnId+"/"+defaultTagName+"";
        String downloadURL = "fileDownload('" + file + "','actual','" + txnId + "','" + defaultTagName + "')";
        String deleteAction = "DeleteConsignmentRecord('" + txnId + "','" + id + "','" + requestTypeValue + "')";
        String historyAction = "historyRecord('" + txnId + "','" + requestTypeValue + "','" + source + "')";


        if (source.equals("5") && requestTypeValue.equals("0")) {
            //check for Stolen/Indvisual

            editAction = "openStolenRecoveryPage('editIndivisualsStolen','edit','" + txnId + "','" + requestSource + "')";
            viewAction = "openStolenRecoveryPage('editIndivisualsStolen','view','" + txnId + "','" + requestSource + "')";

        } else if (source.equals("6") && requestTypeValue.equals("0")) {
            //check for Stolen/Company

            editAction = "openStolenRecoveryPage('editCompanyStolen','edit','" + txnId + "','" + requestSource + "')";
            viewAction = "openStolenRecoveryPage('editCompanyStolen','view','" + txnId + "','" + requestSource + "')";

        } else if (source.equals("5") && requestTypeValue.equals("1")) {
            //check for Recovery/single

            editAction = "openStolenRecoveryPage('editIndivisualRecovery','edit','" + txnId + "','" + requestSource + "')";
            viewAction = "openStolenRecoveryPage('editIndivisualRecovery','view','" + txnId + "','" + requestSource + "')";

        } else if (source.equals("6") && requestTypeValue.equals("1")) {
            //check for Recovery/company

            editAction = "openStolenRecoveryPage('editCompanyRecovery','edit','" + txnId + "','" + requestSource + "')";
            viewAction = "openStolenRecoveryPage('editCompanyRecovery','view','" + txnId + "','" + requestSource + "')";

        }


        log.info("source->" + source + "status-->" + status);
        /*
         * else {
         *
         * log.info("else condition..");
         * editAction="openStolenRecoveryPage('editCompanyRecovery','edit')";
         * viewAction="openStolenRecoveryPage('editCompanyRecovery','view')";
         *
         * }
         */


        // state related Code
        String error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\" ><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";

        log.info("source---> " + source + "  status----> " + status);

        if ((status.equals("0")) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        } else if ((status.equals("1") || status.equals("3") || status.equals("5") || status.equals("6") || "7".equals(status)) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        } else if ((status.equals("4")) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        } else if ((status.equals("2")) && ("Approved".equals(userStatus))) {
            error = "<a onclick=" + errorURL + "  class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            download = "<a onclick=" + downloadURL + "  class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + "  class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            view = "<a onclick=" + viewAction + "  class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        } else if ((status != "0" || status != "1" || status != "2" || status != "3" || status != "4" || status != "5" || status != "6" || status != "7" || status == null || status.equals("")) && ("Approved".equals(userStatus))) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        }


        if ((source.equals("5")) && "Approved".equals(userStatus)) {
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";

        }

        if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";

            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";

            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";

        }


        String action = error.concat(download).concat(view).concat(edit).concat(delete).concat(history);
        return action;

    }

    /********************************** Icons for Audit Management**********************************/

    public String auditManagementIcons(String userStatus, String userId, String id) {
        executePostConstruct();
        String viewAction = "viewDetails('" + id + "')";

        // state related Code
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";


        String action = view;
        return action;

    }

    /********************************** Icons for AdminUPS **********************************/
    public String manageUserIcon(Long imei1, String createdOn, String txnId) {
        String viewAction = "viewDetails('" + imei1 + "')";

        String editAction = "";


        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";


        String action = view.concat(edit);
        return action;
    }

    public String endUserGrievanceState(String fileName, String txnId, String grievanceId, Integer userId, String status) {
        executePostConstruct();
        log.info(" entry in set view in data table.....");
        String replyAction = "endUserGrievanceReply('" + userId + "','" + grievanceId + "','" + txnId + "')";
        String viewAction = "endUserviewGrievanceHistory('" + grievanceId + "','" + projectPath + "','" + userId + "')";

        // state related Code
        String reply = "<a onclick=" + replyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + replyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        log.info("set StatusofGrievance....." + status);

        if ("0".equals(status) || "1".equals(status) || "2".equals(status)) {
            reply = "<a onclick=" + replyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + replyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        } else if ("3".equals(status)) {
            reply = "<a onclick=" + replyAction + " class=\"eventNone\"><i class=" + disableReplyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
        } else if (status != "0" || status != "1" || status != "3" || status == null || status.equals("")) {
            reply = "<a onclick=" + replyAction + " class=\"eventNone\"><i class=" + disableReplyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        }

        String action = reply.concat(view);
        return action;
    }


    /********************************** Icons for Importer TRC Datatable **********************************/


    public String importalTrcManageIcons(String status, Integer id, String txnId, String userStatus, String fileName) {
        // URL link
        //String downloadURL = "JavaScript:void(0)";
        log.info("fileName in Admin Icon-->" + fileName);
        String errorURL = "fileDownload('" + fileName.replace(" ", "%20") + "','error','" + txnId + "','" + defaultTagName + "')";
        String viewAction = "ImporterviewByID(" + id + ",'view','" + projectPath + "','viewImporterModal')";
        String editAction = "ImporterviewByID(" + id + ",'edit','" + projectPath + "','importereditModal')";

        String deleteAction = "DeleteTacRecord('" + txnId + "'," + id + ")";
        // state related Code

        String historyAction = "historyRecord('" + txnId + "')";

        String error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"> <i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";

        if (("7".equals(status)) && "Approved".equals(userStatus)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        } else if ("0".equals(status) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        } else if (("1".equals(status) || "3".equals(status) || "4".equals(status) || "6".equals(status) || "8".equals(status)) && ("Approved".equals(userStatus))) {
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        } else if ("2".equals(status) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + "><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "></i></a>";
            view = "<a onclick=" + viewAction + "><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

            edit = "<a onclick=" + editAction + "><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

            history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        } else if ((status != "0" || status != "1" || status != "3" || status != "4" || status != "6" || status != "7" || status == null || status.equals("")) && ("Approved".equals(userStatus))) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";

            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        } else if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            edit = "<a onclick=" + editAction + " class=" + disableIconClass + "><i class=" + disableEditIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
        }

        String action = error.concat(view).concat(edit).concat(delete).concat(history);
        return action;

    }

    /********************************** Icons for Device Activation **********************************/

    public String deviceActivationIcon(String imei1, String createdOn, String txnId, String status, String userStatus, String source) {
        executePostConstruct();
        String viewAction = "viewDetails('" + imei1 + "','" + txnId + "','" + source + "')";
        String deleteAction = "deleteByImei('" + imei1 + "','" + txnId + "')";
        String errorURL = "fileDownload('','error','" + txnId + "','" + defaultTagName + "')";

        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
        String error = "<a onclick=" + errorURL + "><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "></i></a>";


        String historyAction = "historyRecord('" + txnId + "')";
        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";

        if (("3".equals(status) || "6".equals(status) || "7".equals(status)) && "Approved".equals(userStatus)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
        } else if ("0".equals(status) && "Approved".equals(userStatus)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";

        } else if ("1".equals(status) && "Approved".equals(userStatus)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";

        } else if ("8".equals(status) && "Approved".equals(userStatus)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
        } else if ("2".equals(status) && "Approved".equals(userStatus)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";


        } else if ((status != "1" || status != "2" || status != "3" || status != "4" || status != "10" || status == null || status.equals("")) && ("Approved".equals(userStatus))) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";

            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";

            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        }


        if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";

            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";

        }

        String action = error.concat(view).concat(delete).concat(history);
        return action;
    }

    /********************************** Icons for Manage Users**********************************/

    public String manageUserIcons(String id, String passportNo) {
        executePostConstruct();
        String viewAction = "viewDetails('" + id + "')";
        String editAction = "edit_immigration?passportNo=" + passportNo + "";
        String ListAction = "deviceActivation?passportNo=" + passportNo + "";
        String AddAction = "";
        // state related Code
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String edit = "<a href=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String List = "<a href=" + ListAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + ListIcon + " aria-hidden=\"true\"  title=" + ListIconTittle + "></i></a>";
        String Add = "<a onclick=" + AddAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + plusIcon + " aria-hidden=\"true\"  title=" + plusIconTittle + "></i></a>";

        String action = view.concat(edit).concat(List).concat(Add);
        return action;

    }


    /********************************** Icons for Importer Admin TRC Manage Type Datatable **********************************/


    public String trcAdminImporterManageIcons(String status, Integer id, String fileName, String txnId) {
        executePostConstruct();
        String viewAction = "viewByID(" + id + ",'view')";
        //String downloadURL = "./Consignment/dowloadFiles/actual/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        String downloadURL = "fileDownload('" + fileName.replace(" ", "%20") + "','actual','" + txnId + "','" + defaultTagName + "')";
        String approveAction = "openApproveTACPopUp('" + txnId + "','')";
        String rejectAction = "openDisapproveTACPopUp('" + txnId + "','')";


        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
        String approve = "<a onclick=" + approveAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + approveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
        String reject = "<a onclick=" + rejectAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + rejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";


        String action = view.concat(download).concat(approve).concat(reject);
        return action;

    }


    /********************************** Icons for Admin TRC Manage Type Admin Datatable **********************************/


    public String trcAdminIcons(String status, Integer id, String fileName, String txnId, String adminApproveStatus) {
        executePostConstruct();
        String viewAction = "viewByID(" + id + ",'view','" + projectPath + "')";
        //	String downloadURL = "./dowloadFiles/actual/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        String downloadURL = "fileDownload('" + fileName.replace(" ", "%20") + "','actual','" + txnId + "','" + defaultTagName + "')";
        String approveAction = "openApproveTACPopUp('" + txnId + "','')";
        String rejectAction = "openDisapproveTACPopUp('" + txnId + "','')";


        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
        String approve = "<a onclick=" + approveAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + approveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
        String reject = "<a onclick=" + rejectAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + rejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";


        if ("0".equals(adminApproveStatus)) {
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
        } else if ("1".equals(adminApproveStatus)) {
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            download = "<a href=" + downloadURL + " ><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
        }

        String action = view.concat(download).concat(approve).concat(reject);
        return action;

    }


    /********************************** Icons for Field Management**********************************/

    public String fieldManagementIcons(String id, String tag, String interp, String tagId) {
        executePostConstruct();

        String editAction = "FieldViewByID('" + tag + "','" + id + "')";
        String deleteAction = "DeleteFieldRecord('" + id + "')";
        // state related Code


        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

        String action = edit.concat(delete);
        return action;

    }

    /********************************** Icons for Port Management**********************************/

    public String portManagementIcons(String id) {
        executePostConstruct();

        String editAction = "PortViewByID('" + id + "')";
        String deleteAction = "DeletePortRecord('" + id + "')";
        // state related Code


        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

        String action = edit.concat(delete);
        return action;

    }

    /********************************** Icons for currency Management**********************************/

    public String currencyManagementIcons(String id, String userStatus) {
        executePostConstruct();

        String editAction = "currencyViewByID('" + id + "')";

        // state related Code


        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";


        String action = edit;
        return action;

    }


    /********************************** Icons for AdminStolen **********************************/

    public String AdminStolenlawfulAgency(String fileName, String txnId, String status, String userStatus, String requestType, int id, Integer qty, String source, String requestTypeValue, String reqType) {
        executePostConstruct();
        // URL link
        String file = fileName == null ? null : fileName.replace(" ", "%20");

        log.info("source  " + source + "  requestTypeValue-->" + requestTypeValue + "  requestType-->" + requestType);

        String viewAction = "";
        String emptyURL = "JavaScript:void(0);";
        String approveAction = "deviceApprovalPopup('" + txnId + "','" + requestTypeValue + "')";
        String rejectAction = "userRejectPopup('" + txnId + "','" + requestTypeValue + "')";
        //	String errorURL = "./Consignment/dowloadFiles/error/"+file+"/"+txnId+"/"+defaultTagName+"";
        String errorURL = "fileDownload('" + file + "','error','" + txnId + "','" + defaultTagName + "')";
        //String downloadURL = "./Consignment/dowloadFiles/actual/"+file+"/"+txnId+"/"+defaultTagName+"";
        String downloadURL = "fileDownload('" + file + "','actual','" + txnId + "','" + defaultTagName + "')";
        String deleteAction = "DeleteConsignmentRecord('" + txnId + "','" + id + "','" + requestTypeValue + "')";

        String historyAction = "historyRecord('" + txnId + "','" + requestTypeValue + "','" + source + "')";
        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        if (source.equals("5") && requestTypeValue.equals("0")) {
            //check for Stolen/Indvisual
            viewAction = "openStolenRecoveryPage('editIndivisualsStolen','view','" + txnId + "','" + reqType + "')";

        } else if (source.equals("6") && requestTypeValue.equals("0")) {
            //check for Stolen/Company
            viewAction = "openStolenRecoveryPage('editCompanyStolen','view','" + txnId + "','" + reqType + "')";

        } else if (source.equals("5") && requestTypeValue.equals("1")) {
            //check for Recovery/single
            viewAction = "openStolenRecoveryPage('editIndivisualRecovery','view','" + txnId + "','" + reqType + "')";

        } else if (source.equals("6") && requestTypeValue.equals("1")) {
            //check for Recovery/company
            viewAction = "openStolenRecoveryPage('editCompanyRecovery','view','" + txnId + "','" + reqType + "')";

        }
        /*
         * else {
         *
         * log.info("else condition..");
         * editAction="openStolenRecoveryPage('editCompanyRecovery','edit')";
         * viewAction="openStolenRecoveryPage('editCompanyRecovery','view')";
         *
         * }
         */


        // state related Code
        String error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        String approve = "<a onclick=" + approveAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + approveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
        String reject = "<a onclick=" + rejectAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + rejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";

        log.info("source->" + source + "status-->" + status);

        if (("0".equals(status) || "1".equals(status) || "6".equals(status) || "7".equals(status) || "5".equals(status) || "4".equals(status)) && ("Approved".equals(userStatus))) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";

        } else if ("3".equals(status)) {
            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";

        } else if ("2".equals(status)) {
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";

        } else if (status != "0" || status != "1" || status != "2" || status != "3" || status != "4" || status != "5" || status != "6" || status != "7" || status == null || status.equals("")) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        }

        if ((source.equals("4") || source.equals("5"))) {
            download = "<a onclick=" + downloadURL + "  class=\"eventNone\"><i class=" + disableDownloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
        }

        if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            delete = "<a onclick=" + deleteAction + " class=\"eventNone\"><i class=" + disableDeletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";

            error = "<a onclick=" + errorURL + " class=\"eventNone\"><i class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + " ></i></a>";

        }


        //String action=error.concat(download).concat(view).concat(edit).concat(delete);
        String action = error.concat(download).concat(view).concat(approve).concat(reject).concat(delete).concat(history);
        return action;
    }

    /********************************* Icons for Custmer Care Notification *********************************/


    public String ccNotificationIcon() {
        executePostConstruct();

        String viewAction = "";

        String view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";


        String action = view;
        return action;

    }

    /********************************** Icons for User Management**********************************/

    public String userManagementIcons(String id, String userStatus) {
        executePostConstruct();

        String editAction = "userChangeStatus('" + id + "')";

        // state related Code


        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";


        String action = edit;
        return action;

    }

    /********************************** Icons for Rule List**********************************/

    public String ruleListIcons(String id, String output) {
        executePostConstruct();

        String editAction = "getDetailBy('" + id + "','" + output + "')";
        String viewAction = "viewByID('" + id + "','" + output + "')";

        // state related Code


        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";

        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        String action = view.concat(edit);
        return action;

    }


    /********************************** Icons for Rule Feature Mapping List**********************************/

    public String ruleFeatureMappingIcons(String id) {
        executePostConstruct();

        String editAction = "getDetailBy('" + id + "')";

        String viewAction = "viewDetailBy(" + id + ")";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";


        // state related Code
		/*String deleteAction ="DeleteByID('"+id+"')";
		String delete="<a onclick="+deleteAction+" class=\"waves-effect waves-light modal-trigger\"><i class="
				+deletionIcon+" aria-hidden=\"true\"  title="
				+deleteIconTitle+"></i></a>";*/
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";


        String action = view.concat(edit);
        return action;

    }


    /********************************** Icons for alert Management**********************************/

    public String alertManagementIcons(String id) {
        executePostConstruct();

        String editAction = "alertViewByID('" + id + "')";

        // state related Code

        String viewAction = "viewDetailBy('" + id + "')";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";

        String action = view.concat(edit);
        return action;

    }

    /********************************** Icons for custom **********************************/

    public String consignmentDRTState(String fileName, String txnId, String status, String userStatus, String displayName, String recordId) {

        // URL link
        // call post construct
        executePostConstruct();
        String emptyURL = "JavaScript:void(0);";
        //String downloadURL = "./dowloadFiles/actual/"+fileName.replace(" ", "%20")+"/"+txnId+"/"+defaultTagName+"";
        String downloadURL = "fileDownload('" + fileName.replace(" ", "%20") + "','actual','" + txnId + "','" + defaultTagName + "')";
        String viewAction = "viewConsignmentDetails('" + txnId + "')";
        String approveAction = "openDRTPopUp('" + recordId + "')";

        /* String escapedString = queryParser.escape(approveAction); */
        String rejectAction = "openDisapprovePopup('" + txnId + "')";


        // state related Code
        String download = "<a onclick=" + downloadURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + downloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";

        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        String approve = "<a onclick=" + approveAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + approveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";


        String reject = "<a onclick=" + rejectAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + rejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";

        if ("6".equals(status) && "Approved".equals(userStatus)) {
            approve = "<a onclick=" + approveAction + " class=" + disableIconClass + "><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";


        } else if ("10".equals(status) && "Approved".equals(userStatus)) {
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";


        } else if (("9".equals(status)) && "Approved".equals(userStatus)) {
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
        } else if ((status != "6" || status != "7" || status != "9" || status != "10" || status == null || status.equals("")) && ("Approved".equals(userStatus))) {
            download = "<a onclick=" + downloadURL + "  class=" + disableIconClass + "><i class=" + disableDownloadIcon + " aria-hidden=\"true\"  title=" + downloadIconTitle + " ></i></a>";
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        } else if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
        }


        String action = download.concat(view).concat(approve).concat(reject);
        return action;
    }

    /********************************** Icons Admin Pending TAC Management**********************************/

    public String adminPendingTacIcons(String txnId, String id) {
        executePostConstruct();

        String deleteAction = "DeleteByID('" + txnId + "','" + id + "')";
        // state related Code

        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        String action = delete;
        return action;

    }

    /********************************** Icons End userRegister device**********************************/
    public String endUserPaidStatusIcon(String imei1, String userStatus, String status, String txnId) {
        executePostConstruct();
        String viewAction = "viewDetails('" + imei1 + "','" + txnId + "')";
        String deleteAction = "deleteByImei('" + imei1 + "')";
        String errorURL = "fileDownload('','error','" + txnId + "','" + defaultTagName + "')";

        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";
        String error = "<a onclick=" + errorURL + " class=\"waves-effect waves-light modal-trigger\"><i class=" + errorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "></i></a>";


        String historyAction = "historyRecord('" + txnId + "')";
        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";

        if (("3".equals(status) || "6".equals(status) || "7".equals(status))) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
        } else if ("0".equals(status)) {
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";

        } else if ("1".equals(status)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";

        } else if ("8".equals(status)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

            error = "<a onclick=" + errorURL + " class=" + disableIconClass + "><i  class=" + disableErrorIcon + " aria-hidden=\"true\" title=" + errorIconTitle + "  ></i></a>";
        } else if ("2".equals(status) && "Approved".equals(userStatus)) {
            delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger eventNone\" ><i class=" + disableDeletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";


        }

        String action = error.concat(view).concat(delete).concat(history);
        return action;

    }


    /********************************* Icons for Grievance Customer grievance *********************************/

    public String customerCareGrievanceState(String fileName, String txnId, String grievanceId, String status, String userStatus, int userId) {
        executePostConstruct();
        String replyAction = "grievanceReply('" + userId + "','" + grievanceId + "','" + txnId + "')";
        String viewAction = "viewGrievanceHistory('" + grievanceId + "')";

        // state related Code
        String reply = "<a onclick=" + replyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + replyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";


        reply = "<a onclick=" + replyAction + " class=\"eventNone\"><i class=" + disableReplyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";

        if ("0".equals(status) || "1".equals(status) || "2".equals(status)) {
            reply = "<a onclick=" + replyAction + " class=\"eventNone\"><i class=" + disableReplyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
        } else if ("3".equals(status)) {
            reply = "<a onclick=" + replyAction + " class=\"eventNone\"><i class=" + disableReplyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
        } else if ((status != "0" || status != "1" || status != "2" || status != "3" || status == null || status.equals("")) && ("Approved".equals(userStatus))) {
            reply = "<a onclick=" + replyAction + " class=\"eventNone\"><i class=" + disableReplyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        }

        if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            reply = "<a onclick=" + replyAction + " class=\"eventNone\"><i class=" + disableReplyIcon + " aria-hidden=\"true\" title=" + replyIconTitle + " ></i></a>";
        }


        String action = reply.concat(view);
        return action;
    }

    /********************************** Icons System User Management**********************************/

    public String userSystemManagementIcons(String id) {
        executePostConstruct();

        String editAction = "viewDetails(" + id + ",'Edit')";
        String viewAction = "viewDetails(" + id + ",'View')";
        String deleteAction = "DeleteByID('" + id + "')";

        // state related Code


        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\" title=" + deleteIconTitle + "></i></a>";


        String action = view.concat(edit).concat(delete);
        return action;

    }

    /********************************** Icons for Admin Visa Update Datatable **********************************/


    public String visaUpdateAdminIcons(String status, String id, Integer endUserId, String txnid, String userStatus, String source) {
        executePostConstruct();
        String viewAction = "viewDetails('" + id + "','" + endUserId + "','" + source + "','" + txnid + "')";

        String approveAction = "deviceApprovalPopup('" + id + "','" + endUserId + "','" + txnid + "')";
        String rejectAction = "userRejectPopup('" + id + "','" + endUserId + "','" + txnid + "')";
        String historyAction = "historyRecord('" + txnid + "')";

        String history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";

        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

        /*
         * String download="<a onclick="+downloadURL+" ><i class="
         * +downloadIcon+" aria-hidden=\"true\" title=" +downloadIconTitle+" ></i></a>";
         */
        String approve = "<a onclick=" + approveAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + approveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
        String reject = "<a onclick=" + rejectAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + rejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";


        if ("6".equals(status) && "Approved".equals(userStatus)) {
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
        } else if ("3".equals(status) && "Approved".equals(userStatus)) {

            history = "<a onclick=" + historyAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + historyIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";

            view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

            approve = "<a onclick=" + approveAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + approveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + "><i class=" + rejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
        } else if ("7".equals(status) && "Approved".equals(userStatus)) {
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
        } else if (status != "6" || status != "7" || status != "3" || status == null || status.equals("")) {
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
            view = "<a onclick=" + viewAction + " class=" + disableIconClass + "><i class=" + disableViewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";

            history = "<a onclick=" + historyAction + " class=" + disableIconClass + "><i class=" + disableHistoryIcon + " aria-hidden=\"true\"  title=" + historyTitle + "></i></a>";
        }


        if ("Disable".equals(userStatus)) {
            log.info("CURRENT USER CANN'T ACCESS BCOZ STATUS IS::::::" + userStatus);
            approve = "<a onclick=" + approveAction + " class=\"eventNone\"><i class=" + disableApproveIcon + " aria-hidden=\"true\" title=" + approveIconTitle + " ></i></a>";
            reject = "<a onclick=" + rejectAction + " class=\"eventNone\"><i class=" + disableRejectIcon + " aria-hidden=\"true\" title=" + rejectIconTitle + " ></i></a>";
        }

        String action = view.concat(approve).concat(reject).concat(history);
        return action;

    }

    @PostConstruct
    public void executePostConstruct() {
        errorIconTitle = Translator.toLocale("titles.Error_File");
        downloadIconTitle = Translator.toLocale("titles.Download");
        viewIconTitle = Translator.toLocale("titles.View");
        editIconTitle = Translator.toLocale("titles.Edit");
        deleteIconTitle = Translator.toLocale("titles.Delete");
        replyIconTitle = Translator.toLocale("titles.Reply");
        approveIconTitle = Translator.toLocale("titles.Approve");
        rejectIconTitle = Translator.toLocale("titles.Reject");
        payTaxIconTitle = Translator.toLocale("titles.Pay_Tax");
        ListIconTittle = Translator.toLocale("titles.List");
        plusIconTittle = Translator.toLocale("titles.Add_device");
        historyTitle = Translator.toLocale("titles.history");
    }

    /********************************** Icons for Address Management**********************************/

    public String addressManagementIcons(String id) {
        executePostConstruct();
        String editAction = "viewDetails(" + id + ")";
        String deleteAction = "deleteAction('" + id + "')";

        // state related Code

        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";

        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

        String action = edit.concat(delete);
        return action;

    }

    /********************************** Icons for Schedule Management**********************************/

    public String scheduleManagementIcons(String id, String userStatus) {
        executePostConstruct();

        String editAction = "viewDetails(" + id + ",'Edit')";
        String viewAction = "viewDetails(" + id + ",'View')";
        String deleteAction = "DeleteByID('" + id + "')";

        // state related Code
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";

        String action = view.concat(edit).concat(delete);
        return action;

    }

    /********************************** Icons for DeviceManagement **********************************/

    public String iconsDeviceManagement(String tac, String requestType, Integer deviceState, Integer rowId, Integer featureId) {
        executePostConstruct();
        // URL link
        //log.info("status---->"+status+"---------AdminCurrentStatus------>"+AdminCurrentStatus+" userStatus----------->" +userStatus);
        String action = null;
        String threeDot = null;
        String viewHistoryAction = "viewHistoryDetails('" + tac + "','" + rowId + "')";
        String viewAction = "viewDetails('" + tac + "','View')";
        String editAction = "viewDetails('" + tac + "','Edit')";
        String deleteAction = "deleteDevice('" + tac + "')";
        String CopyAction = "copyDetails('" + tac + "','copy')";
        String copyViewAction = "viewDetails('" + tac + "','copyView')";
        String historyAdction = "viewHistory('" + tac + "')";

        log.info("deviceState is " + deviceState);
        if ("multiedit".equals(requestType)) {
            if (deviceState == 0) {
                String checkboxes = "<label class=\"checkbox-container\"><input type=\"checkbox\" id=\"tableCheckBox" + tac + "\" name=\"selector\" value=" + tac + " class=\"select-row\"><span class=\"checkmark\"></span></label>";
                action = checkboxes;
            }
        } else if ("copyfrom".equals(requestType)) {
            String copy = "<a onclick=" + CopyAction + " class=\"waves-effect waves-light modal-trigger\"  data-dismiss=\"modal\"><i class=" + copyIcon + " aria-hidden=\"true\" title="
                    + CopyTitle + " ></i></a>";
            String view = "<a href=\"#\"  onclick=" + copyViewAction + " class=\"waves-effect waves-light modal-trigger\" data-toggle=\"modal\" data-target=\"#CopyForm-view\">\n"
                    + "<i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + "></i>\n"
                    + "</a>";
            action = view.concat(copy);
        } else if ("viewHistory".equals(requestType)) {
            String viewIcon = "<a onclick=" + viewHistoryAction + " title=" + viewIconTitle + "><img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\"></a>";
            action = viewIcon;
        } else if (deviceState == 2) {
            threeDot = "<div class=\"dropdown\"><a class=\"nav-link dropdown-toggle text-center p-0\" href=\"#\" id=\"navbardrop\" data-toggle=\"dropdown\" aria-expanded=\"false\" style=\"pointer-events: none\">︙</a>"
                    + "<div class=\"dropdown-menu dropdown-menu-right\" style=\"\">"
                    + "<a onclick=" + viewAction + " class=\"dropdown-item\"><img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\">" + viewIconTitle + "</a>"
                    + "<a onclick=" + editAction + " class=\"dropdown-item\" href=\"#\"><img src=\"./resources/assets/images/edit-iconBlue.svg\" alt=\"icon\" class=\"img-fluid\">  " + editIconTitle + "</a>"
                    + "<a onclick=" + historyAdction + " class=\"dropdown-item\" href=\"#\"> <img src=\"./resources/assets/images/history-icon.svg\" alt=\"icon\" class=\"img-fluid\">  " + historyTitle + "</a>"
                    + "<a onclick=" + deleteAction + " class=\"dropdown-item\" href=\"#\" data-toggle=\"modal\" data-target=\"#deleteModal\"><img src=\"./resources/assets/images/delete-icon.svg\" alt=\"icon\" class=\"img-fluid\">  " + deleteIconTitle + "</a>"
                    + "</div></div>";
        } else if ("dashboardIcon".equals(requestType)) {
            String viewIcon = "<a href=\"#\" onclick=" + viewAction + " title=" + viewIconTitle + "><img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\"></a>";
            action = viewIcon;
        } else {
            threeDot = "<div class=\"dropdown\"><a class=\"nav-link dropdown-toggle text-center p-0\" href=\"#\" id=\"navbardrop\" data-toggle=\"dropdown\" aria-expanded=\"false\">︙</a>"
                    + "<div class=\"dropdown-menu dropdown-menu-right\" style=\"\">"
                    + "<a onclick=" + viewAction + " class=\"dropdown-item\"><img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\">" + viewIconTitle + "</a>"
                    + "<a onclick=" + editAction + " class=\"dropdown-item\" href=\"#\"><img src=\"./resources/assets/images/edit-iconBlue.svg\" alt=\"icon\" class=\"img-fluid\">  " + editIconTitle + "</a>"
                    + "<a onclick=" + historyAdction + " class=\"dropdown-item\" href=\"#\"> <img src=\"./resources/assets/images/history-icon.svg\" alt=\"icon\" class=\"img-fluid\">  " + historyTitle + "</a>"
                    + "<a onclick=" + deleteAction + " class=\"dropdown-item\" href=\"#\" data-toggle=\"modal\" data-target=\"#deleteModal\"><img src=\"./resources/assets/images/delete-icon.svg\" alt=\"icon\" class=\"img-fluid\">  " + deleteIconTitle + "</a>"
                    + "</div></div>";
            action = threeDot;
        }
        String id = "tableCheckBox" + tac;
        return action;

    }

    public String actionIconsList(String id, long featureId) {
        String approveAction = "action('" + id + "','APPROVED')";
        String rejectAction = "action('" + id + "','REJECT')";
        String approve = "";
        String reject = "";
        for (String x : GlobalMap.get((int) featureId)) {
            if (x.equalsIgnoreCase("approve")) {
                approve = "<a onclick=" + approveAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + IconClass.approveFaFaIcon + " aria-hidden=\"true\"  title=" + approveIconTitle + "></i></a>";
            } else if (x.equalsIgnoreCase("reject")) {
                reject = "<a onclick=" + rejectAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + IconClass.rejectFaFaIcon + " aria-hidden=\"true\"  title=" + rejectIconTitle + "></i></a>";
            }
        }
        String action = approve.concat(reject);
        return action;
    }

    public String actionIcons(String id) {
        String editAction = "updateAction('" + id + "')";
        String deleteAction = "deleteAction('" + id + "')";
        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\" ><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";
        String delete = "<a onclick=" + deleteAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + deletionIcon + " aria-hidden=\"true\"  title=" + deleteIconTitle + "></i></a>";
        String action = edit.concat(delete);
        return action;

    }

    public String auditTrailIcon(int id) {

        executePostConstruct();
        String viewAction = "view('" + id + "')";
        // state related Code
        String view = "<a onclick=" + viewAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + viewIcon + " aria-hidden=\"true\" title=" + viewIconTitle + " ></i></a>";
        return view;
    }

    /********************************** Icons for Type Appproved Data**********************************/

    public String TypeApproveIcons(String rootPath, String filename) {
        executePostConstruct();
        String uploadedFile = "processedFile('" + rootPath + "','txt')";
        // state related Code
        //String download = "<a href='" + rootPath + "' download='" + filename + "'><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
        String download = "<a onClick=\"" + uploadedFile + "\"><i class=" + downloadIcon + " aria-hidden=\"true\" title=" + downloadIconTitle + " ></i></a>";
        String action = download;
        return action;

    }

    public String eirsListMgmtIcon(String mode, String status, String pk, String txnId, String file) {
        String uploadedPath = null;
        addMoreFileModel.setTag("system_upload_filepath");
        urlToUpload = feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);
        if (Objects.nonNull(file)) {
            uploadedPath = (urlToUpload.getValue() + txnId + "/" + file).split("webapps")[1];
        }

/*        addMoreFileModel.setTag("upload_file_link");
        urlToUpload = feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);*/
        String processedPath = (urlToUpload.getValue() + txnId + "/" + txnId + ".csv").split("webapps")[1];


        String view = "viewByID('" + pk + "')";
        String processedFile = "processedFile('" + processedPath + "','csv')";
        String uploadedFile = "processedFile('" + uploadedPath + "','csv')";
        String singleAction = null;
        String bulkAction = null;
        String action = null;

        String viewAction = "<div class=\"card-action\">\n" + "                                        <a class=\"nav-link dropdown-toggle text-center p-0\"  id=\"navbardrop\"\n" + "                                            data-toggle=\"dropdown\">︙</a>\n" + "                                        <div class=\"dropdown-menu dropdown-menu-right\">\n" + "                                            <a onclick=\"" + view + "\" class='dropdown-item' >\n" + "                                                <img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\">\n" + "                                                View\n" + "                                            </a></div></div>";

        String initClass = status.equalsIgnoreCase("INIT") ? "disabled-btn" : "";
        if (mode.equalsIgnoreCase("single")) {
            singleAction = "<div class=\"card-action\">\n" + "                                        <a class=\"nav-link dropdown-toggle text-center p-0\" id=\"navbardrop\"\n" + "                                            data-toggle=\"dropdown\">︙</a>\n" + "                                        <div class=\"dropdown-menu dropdown-menu-right\">\n" + "                                            <a onclick=\"" + view + "\" class='dropdown-item' >\n" + "                                                <img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\">\n" + "                                                View\n" + "                                            </a>\n" + "                                            <a onClick=\"" + processedFile + "\" class='" + initClass + " dropdown-item' >\n" + "                                                <img src=\"./resources/assets/images/download-green-icon.svg\" alt=\"icon\" class=\"img-fluid\">\n" + "                                                Processed File\n" + "                                            </a></div></div>";
            action = singleAction;
        } else if (mode.equalsIgnoreCase("bulk")) {

            bulkAction = "<div class=\"card-action\">\n" + "                                        <a class=\"nav-link dropdown-toggle text-center p-0\" href=\"#\" id=\"navbardrop\"\n" + "                                            data-toggle=\"dropdown\">︙</a>\n" + "                                        <div class=\"dropdown-menu dropdown-menu-right\">\n" + "                                            <a onclick=\"" + view + "\" class='dropdown-item' >\n" + "                                                <img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\">\n" + "                                                View\n" + "                                            </a>\n" + "                                            <a  onClick=\"" + uploadedFile + "\"  class=\"dropdown-item\" >\n" + "                                                <img src=\"./resources/assets/images/download-icon-blue.svg\" alt=\"icon\" class=\"img-fluid\"> Uploaded File \n" + "                                            </a>\n" + "                                            <a class='" + initClass + " dropdown-item' onClick=\"" + processedFile + "\" >\n" + "                                                <img src=\"./resources/assets/images/download-green-icon.svg\" alt=\"icon\" class=\"img-fluid\">\n" + "                                                Processed File\n" + "                                            </a></div></div>";
            action = bulkAction;
        }

        return action;

    }

    public String duplicateActionIconsList(Integer id, String status, String redmineTktId) {
        String approveAction = "approveDevice('" + id + "')";
        String viewAction = "viewDevice('" + id + "','" + redmineTktId + "')";

        String viewIcon = null;
        String approveIcon = null;
        String action = null;

        /*if ("Duplicate".equalsIgnoreCase(status)) {
            approveIcon = "<a onclick=" + approveAction + " class=\"waves-effect waves-light modal-trigger\"><i class="
                    + IconClass.approveFaFaIcon + " aria-hidden=\"true\"  title="
                    + approveIconTitle + "></i></a>";
            action = approveIcon;
        } else*/

        if ("Original".equalsIgnoreCase(status)) {
            viewIcon = "<a onclick=" + viewAction + " title=" + viewIconTitle + "><img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\"></a>";
            action = viewIcon;
        }

        return action;
    }

    public String notificationResentFeature(String id) {

        String viewAction = "view('" + id + "')";
        // state related Code
        String viewIcon = "<a onclick=" + viewAction + " title=" + viewIconTitle + "><img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\"></a>";
        return viewIcon;
    }

    public String StolenImeiStatusCheckIconsList(Integer id, String transactionId, String countFoundInLost) {
        String viewAction = "viewStolenDevice('" + id + "','" + transactionId + "')";

        String viewIcon = null;
        String action = null;

        if (countFoundInLost == null || countFoundInLost.isEmpty() || countFoundInLost.equals("0")) {
            viewIcon = "<a onclick=" + viewAction + " title=" + viewIconTitle + " style=\"\n" +
                    "    pointer-events: none;\n" +
                    "    color: gray;\n" +
                    "    opacity: 0.6;\n" +
                    "\"><img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\"></a>";
        } else {
            viewIcon = "<a onclick=" + viewAction + " title=" + viewIconTitle + "><img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\"></a>";
        }

        action = viewIcon;

        return action;
    }

    public String traclLostActionIconsList(String id, String status, String lang) {
        String viewAction = "viewDevice('" + id + "')";

        String viewIcon = null;
        String action = null;
        viewIcon = "<a onclick=" + viewAction + " title=" + viewIconTitle + "><img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\"></a>";
        action = viewIcon;

        return action;

    }

    public String policeBulkViewIconsList(String id, String status, String requestMode, String url, String url2, String lang, String featureid) {
        //String viewAction = "viewDevice('" + id + "')";
        String viewAction = "./viewPoliceBulkViewDetails?lang=" + lang + "&requestId=" + id + "&featureId=" + featureid;
        String policeFIRUpload = "policeFIRUpload('" + id + "')";
        String viewIcon = null;
        String action = null;
        if (status.equalsIgnoreCase("DONE") || status.equalsIgnoreCase("FAIL")) {
            viewIcon = "<div class=\"card-action\">\n" + " <a class=\"nav-link dropdown-toggle text-center p-0\" href=\"#\" id=\"navbardrop\"\n" + " data-toggle=\"dropdown\">︙</a>\n" + " <div class=\"dropdown-menu dropdown-menu-right\">\n" + " <a  href=" + viewAction + " class=\"dropdown-item\" >\n" + " <img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\"> View \n" + " </a>\n" + " <a  href=" + url + " class=\"dropdown-item\" >\n" + " <img src=\"./resources/assets/images/download-icon-blue.svg\" alt=\"icon\" class=\"img-fluid\"> Download Uploaded File </a>\n" + "<a  href=" + url2 + " class=\"dropdown-item\" >\n" + "<img src=\"./resources/assets/images/download-green-icon.svg\" alt=\"icon\" class=\"img-fluid\"> Download Processed File </a>\n" + "</div></div>";
        } else {
            viewIcon = "<div class=\"card-action\">\n" + " <a class=\"nav-link dropdown-toggle text-center p-0\" href=\"#\" id=\"navbardrop\"\n" + " data-toggle=\"dropdown\">︙</a>\n" + " <div class=\"dropdown-menu dropdown-menu-right\">\n" + " <a  href=" + viewAction + " class=\"dropdown-item\" >\n" + " <img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\"> View \n" + " </a>\n" + " <a  href=" + url + " class=\"dropdown-item\" >\n" + " <img src=\"./resources/assets/images/download-icon-blue.svg\" alt=\"icon\" class=\"img-fluid\"> Download Uploaded File </a>\n" + "</div></div>";
        }


        action = viewIcon;
        return action;
    }

    public String policActionIconsList(String id, String status, String requestMode) {
        String viewAction = "viewDevice('" + id + "')";
        String policeFIRUpload = "policeFIRUpload('" + id + "')";
        String approveAction = "openApprovePopUp('" + id + "')";
        String rejectAction = "openDisapprovePopup('" + id + "')";
        String stolenView = "";
        String bulkAction = "";
        if (status.equalsIgnoreCase("INIT")) {
            bulkAction = "<div class=\"card-action\">\n" + "                                        <a class=\"nav-link dropdown-toggle text-center p-0\" href=\"#\" id=\"navbardrop\"\n" + "                                            data-toggle=\"dropdown\">︙</a>\n" + "                                        <div class=\"dropdown-menu dropdown-menu-right\">\n" + "                                            <a onclick=" + viewAction + " class='dropdown-item' >\n" + "                                                <img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\">\n" + "                                                View\n" + "                                            </a>\n" + "                                            <a  onclick=" + policeFIRUpload + " class=\"dropdown-item\" >\n" + "                                                <img src=\"./resources/assets/images/check.svg\" alt=\"icon\" class=\"img-fluid\"> Verify \n" + "                                            </a>\n" + "                                            </a></div></div>";

        } else {
            if (requestMode.equalsIgnoreCase("Bulk")) {
                log.info("request modvalue in bulk case" + requestMode);
                stolenView = "./viewPoliceBulkViewDetails?requestId=" + id;
                bulkAction = "<div class=\"card-action\">\n" + " <a class=\"nav-link dropdown-toggle text-center p-0\" href=\"#\" id=\"navbardrop\"\n" + " data-toggle=\"dropdown\">︙</a>\n" + " <div class=\"dropdown-menu dropdown-menu-right\">\n" + " <a  onclick=" + approveAction + " class=\"dropdown-item\" >\n" + " <img src=\"./resources/assets/images/download-icon-blue.svg\" alt=\"icon\" class=\"img-fluid\"> Download Uploaded File </a>\n" + "<a  onclick=" + rejectAction + " class=\"dropdown-item\" >\n" + "<img src=\"./resources/assets/images/download-green-icon.svg\" alt=\"icon\" class=\"img-fluid\"> Download Processed File </a>\n" + " <a  href=" + stolenView + " class=\"dropdown-item\" >\n" + " <img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\"> View \n" + " </a>\n" + " </a></div></div>";
            } else {
                stolenView = "./viewPoliceSingleViewDetails?requestId=" + id;
                bulkAction = "<div class=\"card-action\">\n" + "                                        <a class=\"nav-link dropdown-toggle text-center p-0\" href=\"#\" id=\"navbardrop\"\n" + "                                            data-toggle=\"dropdown\">︙</a>\n" + "                                        <div class=\"dropdown-menu dropdown-menu-right\">\n" +
                        /*
                         * "                                            <a  onclick="
                         * +approveAction+" class=\"dropdown-item\" >\n" +
                         * "                                                <img src=\"./resources/assets/images/check.svg\" alt=\"icon\" class=\"img-fluid\"> Approved \n"
                         * + "                                            </a>\n" +
                         * "                                            <a  onclick="
                         * +rejectAction+" class=\"dropdown-item\" >\n" +
                         * "                                                <img src=\"./resources/assets/images/close-red.png\" alt=\"icon\" class=\"img-fluid\"> Rejected \n"
                         * + "                                            </a>\n" +
                         */
                        "                                            <a  href=" + stolenView + " class=\"dropdown-item\" >\n" + "                                                <img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\"> View \n" + "                                            </a>\n" + "                                            </a></div></div>";
            }

        }

        return bulkAction;

    }

    public String policeViewIconsList(String id, String status, String requestMode, String lang, String featureId) {
        //String viewAction = "viewDevice('" + id + "')";
        String viewAction = "./viewPoliceSingleViewDetails?lang=" + lang + "&requestId=" + id + "&featureId=" + featureId;
        String viewIcon = null;
        String action = null;
        viewIcon = "<a href=" + viewAction + " title=" + viewIconTitle + "><img src=\"./resources/assets/images/eye-icon.svg\" alt=\"icon\" class=\"img-fluid\"></a>";
        action = viewIcon;

        return action;

    }

    /********************************** Icons for Eirs_Response_Param**********************************/
    public String eirsResponseParamIcons(String id) {
        executePostConstruct();
        String editAction = "viewDetails(" + id + ")";

        // state related Code

        String edit = "<a onclick=" + editAction + " class=\"waves-effect waves-light modal-trigger\"><i class=" + editIcon + " aria-hidden=\"true\"  title=" + editIconTitle + "></i></a>";

        return edit;
    }

}