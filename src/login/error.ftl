<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <h1 class="text-2xl font-medium">${msg("errorTitle")}</h1>
    <#elseif section = "form">
        <p class="text-gray-800 mb-4">${message.summary?no_esc}</p>
    <#elseif section = "footer">
        <#if client?? && client.baseUrl?has_content>
            <div class="p-10">
                <a class="flex items-center gap-2 text-xl font-bold text-blue-500" href="${client.baseUrl}">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M7 16l-4-4m0 0l4-4m-4 4h18" />
                    </svg>
                    <span>${msg("backToApplication")}</span>
                </a>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>
