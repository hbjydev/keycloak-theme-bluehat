<#macro alert type="">
    <div class="mb-4 p-4 text-sm <#if type = 'error'>text-red-700 bg-red-100<#else>text-blue-700 bg-blue-100</#if>">
        <#nested />
    </div>
</#macro>