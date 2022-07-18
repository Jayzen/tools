#!/usr/bin/env python
# encoding: utf-8
"""
@author: Jayzen
@software: pycharm
@file: scrape_api.py
@time: 2022/7/12 15:08
@desc:
"""

from jqdatasdk import *
import pandas as pd


def get_province_gdp():
    """
    从https://www.joinquant.com/的api文档中找打对应获取gdp的值
    :return: 各个省历年gdp的值
    """
    auth('tel', 'password')
    pd.set_option('display.max_rows', 100000)
    pd.set_option('display.max_columns', 1000)

    q = query(macro.MAC_AREA_GDP_YEAR)
    df = macro.run_query(q)
    return df


def modify_data():
    """
    对get_province_gdp中的内容进行修改，在本地生成文档
    :return: None
    """
    df = get_province_gdp()
    # df =  df.drop(index = df[(df.area_name == "中国")].index.tolist()) #删除中国这些行的数据
    result = df[["stat_year", "area_name", "gdp"]]. \
        sort_values(by=["area_name", "stat_year"]). \
        pivot(index='area_name', columns='stat_year', values='gdp')
    result.to_excel("final_result.xls")
    return None


if __name__ == '__main__':
    modify_data()
