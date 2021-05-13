<aura:application >
    <aura:attribute name="listaNome" Type="List" default="['Felix','Hillary','Janaina','Luiz','Junior']"/>
    <aura:iteration items="{!v.listaNome}" var="item">
        <aura:if isTrue="{!item == 'Hillary'}">
            <c:Test nome="{!item}"/>
            <br/>
            <aura:set attribute="else">
                O resto é sensualizador de telas
                <br/>
            </aura:set>
        </aura:if>
    </aura:iteration>
</aura:application>