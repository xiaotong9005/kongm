with t as(
SELECT TOP 1000 [序号]
      ,[基金代码]
      ,[简称]
      ,[累计净值]
      ,[净值日期]
	  ,lag([累计净值]) over(partition by [基金代码] order by [序号]) as lag
	  ,lag([MA15]) over(partition by [基金代码] order by [序号]) as lagma15
      ,[MA15]
  FROM [symbol].[dbo].[ma_fund]
  where 基金代码='000001'
)
select * 
,case when lag>lagma15 and [累计净值]<[MA15] then '出' 
	when lag<lagma15 and [累计净值]>[MA15] then '入'
	else ''
 end as status 
from t 
