<?php
/**
 * @copyright (c) shoptimax GmbH | 2011
 * @package smxRemarks
 * @version 1.0
**/
class smx_order_remark extends smx_order_remark_parent {
    
    public function render() {

        $ret = parent::render();
        
        // informationen zur bestellung
        $sAction        = oxConfig::getParameter( "smx_action" );
        $soxId          = oxConfig::getParameter( "oxid" );
        $sRemoxId       = oxConfig::getParameter( "rem_oxid");
        $oOrder         = oxNew( "oxorder" );
        $oOrder->load($soxId);
        $this->_aViewData["order"] = $oOrder;
        
        // cms-seite fuer email-signatur (smxRemarks_signature)
        if($sAction == "smx_mail") {
            $oContent       = oxNew( 'oxcontent' );
            $oContent->loadByIdent( 'smxRemarks_signature' );
            $this->_aViewData["mailSignature"] = strip_tags($oContent->oxcontents__oxcontent->value);
        }
        
        return $ret;
    }
    
    
    /**
     * Saves order history item text changes.
     *
     * @return string
     */
    public function save() {
        
        $sAction    = oxConfig::getParameter( "smx_action" );
        $sText      = oxConfig::getParameter( "remarktext" );
        
        if($sAction == "smx_mail") {
            $sMailTo        = oxConfig::getParameter( "smx_mail_to" );
            $sMailSubject   = oxConfig::getParameter( "smx_mail_subject" );
            
            $sTextNew       = 'eMail an:&nbsp; '.$sMailTo.'<br />';
            $sTextNew      .= 'Betreff:&nbsp;&nbsp;&nbsp; '.$sMailSubject.'<br />';
            $sTextNew      .= '<br />------------------------------------------------------------------------------------------------------------<br /><br />';
            $sTextNew      .= $sText;

            $this->_aViewData["smxMailTo"]          = $sMailTo;
            $this->_aViewData["smxMailSubject"]     = $sMailSubject;
            $this->_aViewData["smxMailMsg"]         = $sText;

            // email-adresse pruefen
            if($this->_checkeMail($sMailTo)) {

                $oEmail = oxNew( 'oxemail' );
                if ( $oEmail->sendEmail( $sMailTo, $sMailSubject, $sText ) ) {
                    // bad workaround ;-)
                    oxUtilsView::getInstance()->addErrorToDisplay( '<span style="color: green;">'.oxLang::getInstance()->translateString('SMX_ORDER_REMARK_EMAIL_OK').'</span>' );
                } else {
                    oxUtilsView::getInstance()->addErrorToDisplay( oxLang::getInstance()->translateString('SMX_ORDER_REMARK_EMAIL_ERROR') );
                }

            }
        } else {
            $sTextNew = $sText;
        }

        $oOrder = oxNew( "oxorder" );
        if ( $oOrder->load( oxConfig::getParameter( "oxid" ) ) ) {
            $oRemark = oxNew( "oxremark" );
            $oRemark->load( oxConfig::getParameter( "rem_oxid" ) );

            // smx_tm
            $oRemark->oxremark__oxtext     = new oxField( $sTextNew );
            $oRemark->oxremark__oxheader   = new oxField( oxConfig::getParameter( "remarkheader" ) );
            
            // smx_tm
            $oRemark->oxremark__oxtype     = new oxField( $sAction );
            $oRemark->oxremark__oxparentid = new oxField( $oOrder->oxorder__oxuserid->value );
            $oRemark->save();
        }
        
    }
    

    protected function _checkeMail($sMailTo) {
        if (!oxUtils::getInstance()->isValidEmail( $sMailTo ) ) {
            oxUtilsView::getInstance()->addErrorToDisplay( oxLang::getInstance()->translateString('SMX_ORDER_REMARK_EMAIL_NOTVALID') );
            return false;
        } else {
            return true;
        }
    }
    
        
}
