# -*- coding:utf-8 -*-
import json
import sqlite3
from pprint import pprint
import os.path
import string
import glob

conn = sqlite3.connect('shiseido-finder.db')
conn.row_factory = sqlite3.Row

# langauges
# ----------------------------------
# 010103    English (for US SIS)
# 010104    English (for US DS)
# 020215    廣東話（香港）
# 020256    English（for Hong Kong）

LANGUAGE_ID = 15


def describe_app_screen(conn, language_id=LANGUAGE_ID):
    c = conn.cursor()
    rows = c.execute('''
    SELECT
      m_app_screen.id,
      json_extract(m_app_screen.content, '$.code') AS code,
      json_extract(m_app_screen_translate.content, '$.name') AS screen_name
    FROM
      m_app_screen LEFT JOIN m_app_screen_translate ON m_app_screen.id = m_app_screen_translate.app_screen_id
      AND m_app_screen_translate.language_id = {0}
    WHERE
      delete_flg = 0
    ORDER BY
      m_app_screen_translate.display_order ASC
    '''.format(language_id)).fetchall()
    c.close()

    for r in rows:
        print("* ({}){}".format(r['code'], r['screen_name']))
        describe_app_item(conn, r['id'])


def describe_app_item(conn, screen_id, language_id=15):
    c = conn.cursor()
    rows = c.execute('''
    SELECT
      json_extract(m_app_item.content, '$.code') AS code,
      json_extract(m_app_item_translate.content, '$.name') AS name,
      json_extract(m_app_item_translate.content, '$.image') AS image
    FROM
      m_app_item LEFT JOIN m_app_item_translate ON m_app_item.id = m_app_item_translate.app_item_id
      AND m_app_item_translate.language_id = {0}
      AND m_app_item.app_screen_id = {1}
    WHERE
      delete_flg = 0
    ORDER BY
      m_app_item_translate.display_order ASC
    '''.format(language_id, screen_id)).fetchall()
    c.close()

    for r in rows:
        if r['name']:
            print("  * ({}){} # {}".format(r['code'], r['name'], r['image']))


def describe_beauty_second(conn, beauty_first_id):
    beauty_second = {}

    c = conn.cursor()
    query = '''
    SELECT
      *
    from
      m_beauty_second
    WHERE
      beauty_first_id = {} AND
      delete_flg = 0
    '''.format(beauty_first_id)
    rows = c.execute(query).fetchall()
    c.close()

    for r in rows:
        c = conn.cursor()
        r_content = json.loads(r['content'])
        rows_translate = c.execute("""
        SELECT
          *
        from
          m_beauty_second_translate
        WHERE
          beauty_second_id = {}
          AND language_id = 15
        ORDER BY
          display_order
        """.format(r['id'])).fetchall()
        c.close()

        for r_translate in rows_translate:
            content = json.loads(r_translate['content'])
            # beauty[ r['id'] ] = content['name']
            print("    - {} ({})".format(content['name'], r_content['code']))


# return beauty



def describe_beauty_first(conn, beauty_category_id):
    beauty_first = {}

    c = conn.cursor()
    query = '''
    SELECT
      *
    from
      m_beauty_first
    WHERE
      beauty_category_id = {} AND
      delete_flg = 0
    '''.format(beauty_category_id)

    rows = c.execute(query).fetchall()
    c.close()

    for r in rows:
        r_content = json.loads(r['content'])
        c = conn.cursor()
        query = """
        SELECT
          *
        from
          m_beauty_first_translate
        WHERE
          beauty_first_id = {}
          AND language_id = 15
        ORDER BY
          display_order
        """.format(r['id'])
        # print(query)
        rows_translate = c.execute(query).fetchall()
        c.close()

        for r_translate in rows_translate:
            content = json.loads(r_translate['content'])
            # beauty[ r['id'] ] = content['name']
            print("  * {} ({})".format(content['name'], r_content['code']))
            describe_beauty_second(conn, r['id'])


# return beauty


def describe_beauty(conn, language_id=LANGUAGE_ID):
    print("\n# 美類\n")

    c = conn.cursor()
    rows = c.execute('''
        SELECT
          m_beauty_category.id,
          json_extract(m_beauty_category.content, '$.code') AS code,
          json_extract(m_beauty_category_translate.content, '$.name') AS name
        FROM
          m_beauty_category LEFT JOIN m_beauty_category_translate ON m_beauty_category.id = m_beauty_category_translate.beauty_category_id
          AND m_beauty_category_translate.language_id = {0}
        WHERE
          delete_flg = 0
        ORDER BY
          m_beauty_category_translate.display_order ASC
        '''.format(language_id)).fetchall()
    c.close()

    for r in rows:
        print("* ({}){}".format(r['code'], r['name']))
        describe_app_item(conn, r['id'])


# print("--------------------------------------")
#     print("美類")
#     print("--------------------------------------")
#     beauty = {}
#
#     c = conn.cursor()
#     rows = c.execute('''
#     SELECT
#       *
#     from
#       m_beauty_category
#     WHERE
#       delete_flg = 0
#     ''').fetchall()
#     c.close()
#
#     for r in rows:
#         # pprint(r['id'])
#         c = conn.cursor()
#         r_content = json.loads(r['content'])
#         query = """
#         SELECT
#           *
#         from
#           m_beauty_category_translate
#         WHERE
#           beauty_category_id = {}
#           AND language_id = 1
#         ORDER BY
#           display_order
#         """.format(r['id'])
#
#         # print(query)
#         rows_translate = c.execute(query).fetchall()
#         c.close()
#
#         for r_translate in rows_translate:
#             content = json.loads(r_translate['content'])
#             beauty[r['id']] = content['name']
#             print("* ({}){} ".format(content['name'], r_content['code']))
#             describe_beauty_first(conn, r['id'])
#
#     return beauty


def describe_line(conn):
    print("--------------------------------------")
    print("LINE")
    print("--------------------------------------")
    beauty = {}

    c = conn.cursor()
    rows = c.execute('''
    SELECT
      *
    from
      m_line
    WHERE
      delete_flg = 0
    ''').fetchall()
    c.close()

    for r in rows:
        # pprint(r['id'])
        c = conn.cursor()
        r_content = json.loads(r['content'])
        query = """
        SELECT
          *
        from
          m_line_translate
        WHERE
          line_id = {}
          AND language_id = 15
        ORDER BY
          display_order
        """.format(r['id'])

        # print(query)
        rows_translate = c.execute(query).fetchall()
        c.close()

        for r_translate in rows_translate:
            content = json.loads(r_translate['content'])
            print("* ({1}){0} ".format(content['name'], r_content['code']))
            for k in content.keys():
                if type(content.get(k)) == list:
                    if content.get(k) != []:
                        print("  - {}".format(k))
                        for l in content.get(k):
                            print("    - {}".format(l))
                    else:
                        if content.get(k):
                            print("  - {}: {}".format(k, content.get(k)))
                else:
                    if content.get(k):
                        print("  - {}: {}".format(k, content.get(k)))


def describe_trouble(conn, language_id):
    print("\n# トラブル\n")

    c = conn.cursor()
    rows = c.execute('''
    SELECT
      m_trouble.id,
      json_extract(m_trouble.content, '$.code') AS code,
      json_extract(m_trouble_translate.content, '$.name') AS name
    FROM
      m_trouble LEFT JOIN m_trouble_translate ON m_trouble.id = m_trouble_translate.trouble_id
      AND m_trouble_translate.language_id = {0}
    WHERE
      delete_flg = 0
    ORDER BY
      m_trouble_translate.display_order ASC
    '''.format(language_id)).fetchall()
    c.close()

    for r in rows:
        print("* ({}){}".format(r['code'], r['name']))


def describe_step_lower(conn, step_upper_id):
    c = conn.cursor()
    query = """
        SELECT
          *
        from
          m_step_lower
        WHERE
          step_upper_id = {}
          AND delete_flg = 0
    """.format(step_upper_id)

    rows = c.execute(query).fetchall()
    c.close()

    for r in rows:
        # pprint(r['id'])
        c = conn.cursor()
        r_content = json.loads(r['content'])
        query = """
            SELECT
              *
            from
              m_step_lower_translate
            WHERE
              step_lower_id = {}
              AND language_id = 1
            ORDER BY
              display_order
            """.format(r['id'])

        # print(query)
        rows_translate = c.execute(query).fetchall()
        c.close()

        for r_translate in rows_translate:
            content = json.loads(r_translate['content'])
            print("  * ({1}){0} ".format(content['name'], r_content['code']))


def describe_step(conn):
    print("\n# ステップ\n")

    c = conn.cursor()
    rows = c.execute('''
        SELECT
          *
        from
          m_step_upper
        WHERE
          delete_flg = 0
        ''').fetchall()
    c.close()

    for r in rows:
        # pprint(r['id'])
        c = conn.cursor()
        r_content = json.loads(r['content'])
        query = """
            SELECT
              *
            from
              m_step_upper_translate
            WHERE
              step_upper_id = {}
              AND language_id = 1
            ORDER BY
              display_order
            """.format(r['id'])

        # print(query)
        rows_translate = c.execute(query).fetchall()
        c.close()

        for r_translate in rows_translate:
            content = json.loads(r_translate['content'])
            print("* ({1}){0} ".format(content['name'], r_content['code']))
            describe_step_lower(conn, r['id'])


def describe_product(conn, language_id):
    c = conn.cursor()
    rows = c.execute('''
    SELECT
      m_product.id AS id,
      m_product.content as content,
      json_extract(m_product.content, '$.line') AS line,
      json_extract(m_product.content, '$.beauty') AS beauty,
      json_extract(m_product.content, '$.region') AS region,
      json_extract(m_product.content, '$.season') AS season,
      json_extract(m_product_translate.content, '$.name') AS name,
      json_extract(m_product_translate.content, '$.movie') AS movie,
      json_extract(m_product_translate.content, '$.image') AS image,
      json_extract(m_product_translate.content, '$.feature') AS feature
    FROM
      m_product LEFT JOIN m_product_translate ON m_product.id = m_product_translate.product_id
      AND m_product_translate.language_id = {0}
    WHERE
      json_extract(m_product_translate.content, '$.name') != ""
      AND json_extract(m_product_translate.content, '$.image') != ""
      AND delete_flg = 0
    ORDER BY
      CAST (json_extract(m_product.content, '$.line') AS INTEGER ) ASC,
      CAST (json_extract(m_product.content, '$.beauty') AS INTEGER ) ASC,
      m_product_translate.display_order ASC
    '''.format(language_id)).fetchall()
    c.close()

    print("""
| ID | LINE | 美類 | 地域 | シーズン | 商品名 | 画像 |
|----|------|------|-----|---------|-------|------|""")
    for r in rows:
        # pprint(json.loads(r['content']))
        print("""| {} | {} | {} | {} | {} | {} | {}({}) |""".format(
            r['id'],
            r['line'],
            r['beauty'],
            r['region'].replace("\n", ','),
            r['season'],
            r['name'].replace("\n", ','),
            r['image'],
            glob.glob("./images/"+r['image']+"/*")
        ))


if __name__ == "__main__":
    # describe_app_screen(conn)
    # describe_app_item(conn, LANGUAGE_ID)
    # describe_beauty(conn)
    # describe_line(conn)
    # describe_trouble(conn, LANGUAGE_ID)
    # describe_step(conn)
    describe_product(conn, LANGUAGE_ID)
