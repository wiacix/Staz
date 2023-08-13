USE [ecomedia_tychy]

SELECT TOP 50 
Id as ID,
CaseTypeId as CASE_TYPE_ID,
(Select Name From Vindication_CaseType Where Vindication_CaseType.id = Vindication_CaseHeader.CaseTypeId) as CASE_TYPE_NAME,
CustomerCode as CUSTOMER_CODE,
(Select Name From Common_Customer Where Common_Customer.Code = Vindication_CaseHeader.CustomerCode And Active = 1) as CUSTOMER_NAME,
(select sum(wn) - sum(ma) from settlement_settlementheader where Type= 'G' And Id in (select SettlementHeaderId from Vindication_WritingPosition where WritingHeaderId in (select Id from Vindication_WritingHeader where CaseStageHistoryId in (select Id from Vindication_CaseStageHistory where CaseHeaderId = Vindication_CaseHeader.Id)))) as SETTLEMENT_BALANCE,
(select sum(v_wp.wn) - sum(v_wp.ma) from Vindication_WritingPosition v_wp join settlement_settlementheader s_sh on s_sh.id = v_wp.settlementheaderid and s_sh.type='G' where v_wp.WritingHeaderId in (select Id from Vindication_WritingHeader where CaseStageHistoryId = (select max(Id) from Vindication_CaseStageHistory where CaseHeaderId =Vindication_CaseHeader.Id))) as WRITING_BALANCE,
StartDate as START_DATE,
StartUserId as START_USER_ID,
(Select Login from Mlaua_User where Mlaua_User.Id = StartUserId) as START_USER_NAME,
EndDate as END_DATE,
EndUserId as END_USER_ID,
(Select Login from Mlaua_User where Mlaua_User.Id = EndUserId) as END_USER_NAME,
(Select PrintReportTemplate From Vindication_CaseType Where Vindication_CaseType.Id = CaseTypeId) as PRINT_REPORT_TEMPLATE,
(select max(Id) from Vindication_CaseStageHistory where CaseHeaderId = Vindication_CaseHeader.id) as LAST_STAGE_ID,
(Select PrintSubReportTemplate From Vindication_CaseType Where Vindication_CaseType.Id = CaseTypeId) as PRINT_SUBREPORT_TEMPLATE,
InsertDate as INSERT_DATE,
InsertUserId as INSERT_USER_ID,
(select ch.id from vindication_caseheader ch where enddate is not null and enduserId is not null and ch.id = vindication_caseheader.id) as ENDED,
dbo.vch_symbol(id) as STAGE_SYMBOL,
(select sum(wn) - sum(ma) from settlement_settlementheader where Type= 'K' And Id in (select SettlementHeaderId from Vindication_WritingPosition where WritingHeaderId in (select Id from Vindication_WritingHeader where CaseStageHistoryId in (select Id from Vindication_CaseStageHistory where CaseHeaderId = Vindication_CaseHeader.Id)))) as SETTLEMENT_COST_BALANCE,
dbo.vch_deliv_date(id) as DELIVERY_DATE,
(select sum(v_wp.VirtualInterest) from Vindication_WritingPosition v_wp where v_wp.WritingHeaderId in (select Id from Vindication_WritingHeader where CaseStageHistoryId = (select min(Id) from Vindication_CaseStageHistory where CaseHeaderId = Vindication_CaseHeader.Id))) as WRITING_VIRTUAL_INTREST,
(select cast(max(sso.OperationDate) as date) from settlement_settlementoperation sso where sso.systemsymbol in ('KP', 'B+','PZ+') and sso.settlementheaderid in (select Id from settlement_settlementheader where Type= 'G' and Id in (select SettlementHeaderId from Vindication_WritingPosition where WritingHeaderId in (select Id from Vindication_WritingHeader where CaseStageHistoryId in (select Id from Vindication_CaseStageHistory where CaseHeaderId = Vindication_CaseHeader.Id))))) as LAST_MADE_PAYMENT_DATE,
(select cast(max(sso.OperationDate) as date) from settlement_settlementoperation sso where sso.systemsymbol in ('KP', 'B+','PZ+') and sso.settlementheaderid in (select Id from settlement_settlementheader where Type= 'K' and Id in (select SettlementHeaderId from Vindication_WritingPosition where WritingHeaderId in (select Id from Vindication_WritingHeader where CaseStageHistoryId in (select Id from Vindication_CaseStageHistory where CaseHeaderId = Vindication_CaseHeader.Id))))) as LAST_MADE_K_DATE,
(select top 1 cast(EnterDate as date) from Vindication_CaseStageHistory where CaseHeaderId = Vindication_CaseHeader.Id order by Id desc) as LAST_ENTER_DATE,
(SELECT Login FROM Mlaua_User MU_ WHERE MU_.Id = Vindication_CaseHeader.InsertUserId) as InsertUserLogin,
(SELECT Login FROM Mlaua_User MU_ WHERE MU_.Id = Vindication_CaseHeader.ModifyUserId) as ModifyUserLogin,
ModifyDate as ModifyDate,
ModifyUserId as MODIFY_USER_ID 
FROM Vindication_CaseHeader 
WHERE EndDate IS NULL And EndUserId IS NULL 
ORDER BY Id

select top 10 * from Vindication_CaseHeader
select top 10 * from Vindication_CaseType
select top 10 * from Common_Customer
select top 10 * from settlement_settlementheader
select top 10 * from Vindication_WritingPosition
select top 10 * from Vindication_WritingHeader
select top 10 * from Vindication_CaseStageHistory
select top 10 * from Mlaua_User
select top 10 * from settlement_settlementoperation

