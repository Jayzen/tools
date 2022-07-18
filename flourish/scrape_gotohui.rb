#!/usr/bin/env python
# encoding: utf-8
"""
@author: Jay zen
@software: pycharm
@file: scrape_web.py
@time: 2022/7/12 16:18
@desc:
"""
import pandas as pd

pd.set_option('display.max_rows', 100000)
pd.set_option('display.max_columns', 1000)


def get_province_gdp(url, name):
    """
    获取一般省、自治区、直辖市的gdp数据
    :param url: 网站地址
    :param name: 网站地址对应的省、自治区、直辖市的名称
    """
    df = pd.read_html(url)[0][["年份", "GDP(亿元)"]]
    df["省份"] = name
    df = df.pivot(index="省份", columns='年份', values='GDP(亿元)')
    df.to_excel("province.xls")


def get_special_gdp(url, name):
    """
    获取台湾、香港、澳门的gdp数据
    :param url: 网站地址
    :param name: 网站地址对应的台湾、香港、澳门名称
    """
    df = pd.read_html(url)[0][["时间(年)", "GDP(美元)"]]
    df["省份"] = name
    df = df.pivot(index="省份", columns='时间(年)', values='GDP(美元)')
    df.to_excel("special.xls")


if __name__ == '__main__':
    get_province_gdp("https://gdp.gotohui.com/data-2", "浙江")
    get_special_gdp("https://gdp.gotohui.com/data-33", "香港")
