<#macro field
    name
    label
    id=""
    hasError=false
    showError=true
    required=false
    errorMsg=""
    value=""
    placeholder=""

    tabindex=""
    type="text"
    autofocus="off"
    autocomplete="off"
>

    <fieldset class="flex flex-col">
        <label for="${name}" class="text-sm mb-2 font-bold">${label} <#if required><span class="text-red-700">*</span></#if></label>

        <input
            tabindex="${tabindex}"
            id="${id}"
            class="w-full px-2.5 py-1.5 outline-none border border-gray-200 border-b-gray-400 focus:border-blue-500 border-b <#if hasError>border-red-700 border-b-red-700</#if>"
            name="${name}"
            value="${value}"
            type="${type}"
            autofocus="${autofocus}"
            autocomplete="${autocomplete}"
            aria-invalid="<#if hasError>true</#if>"
            placeholder="${placeholder}"
        />

        <#if showError && hasError>
            <span class="text-red-700 text-sm" aria-live="polite">${errorMsg}</span>
        </#if>
    </fieldset>
</#macro>

<#macro checkbox
    name
    label
    id=""
    hasError=false
    showError=true
    errorMsg=""
    checked=false
    value="off"

    tabindex=""
    type="text"
    autofocus="off"
    autocomplete="off"
>
    <fieldset class="flex flex-col">
        <div class="flex items-center gap-1">
            <input
                tabindex="${tabindex}"
                id="${id}"
                name="${name}"
                <#if checked>checked</#if>
                value="${value}"
                type="checkbox"
                autofocus="${autofocus}"
                autocomplete="${autocomplete}"
                aria-invalid="<#if hasError>true</#if>"
            />

            <label for="${name}" class="text-sm font-bold">${label}</label>
        </div>

        <#if showError && hasError>
            <span class="text-red-500 text-sm" aria-live="polite">${errorMsg}</span>
        </#if>
    </fieldset>
</#macro>