<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        <h1 class="text-2xl font-medium">${msg("emailVerifyTitle")}</h1>
    <#elseif section = "form">
        <p class="text-gray-800">
            ${msg("emailVerifyInstruction1")}
        </p>
    <#elseif section = "info">
        <div class="p-10">
            <p class="text-gray-600">
                ${msg("emailVerifyInstruction2")}
            </p>
            <p class="text-gray-600">
                <a class="text-blue-500 underline font-bold" href="${url.loginAction}">${msg("doClickHere")}</a> ${msg("emailVerifyInstruction3")}
            </p>
        </div>
    </#if>
</@layout.registrationLayout>