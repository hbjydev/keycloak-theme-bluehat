<#import "alerts.ftl" as alerts>
<#macro registrationLayout bodyClass="" displayHeader=true displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
<!DOCTYPE html>
<html class="${properties.kcHtmlClass!}">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="robots" content="noindex, nofollow">

        <#if properties.meta?has_content>
            <#list properties.meta?split(' ') as meta>
                <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
            </#list>
        </#if>

        <title>${msg("loginTitle",(realm.displayName!''))}</title>

        <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />

        <link href="${url.resourcesPath}/css/bluehat.css" rel="stylesheet" />
    </head>

    <body>

        <div class="bg-gray-900 text-white flex-grow flex flex-col">
            <main class="flex flex-col h-screen items-center justify-center">
                <div class="bg-gray-100 text-gray-900 max-w-[550px]" style="width: 100%">
                    <div class="p-10 bg-white">
                        <#-- App-initiated actions should not see warning messages about the need to complete the action -->
                        <#-- during login.                                                                               -->
                        <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                            <@alerts.alert type=message.type>
                                <div class="pf-c-alert__icon">
                                    <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                                    <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                                    <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                                    <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                                </div>
                                <span class="${properties.kcAlertTitleClass!}">${kcSanitize(message.summary)?no_esc}</span>
                            </@alerts.alert>
                        </#if>

                        <#if displayHeader>
                            <#nested "header">
                        </#if>

                        <div id="kc-content" class="<#if displayHeader>mt-8</#if>">
                            <#nested "form">

                            <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
                                <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                                    <div class="${properties.kcFormGroupClass!}">
                                        <input type="hidden" name="tryAnotherWay" value="on"/>
                                        <a href="#" id="try-another-way"
                                            onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                                    </div>
                                </form>
                            </#if>
                        </div>

                    </div>
                    <#if displayInfo>
                        <#nested "info">
                    </#if>
                    <#nested "footer">
                </div>
            </main>
        </div>

    </body>
</html>
</#macro>
