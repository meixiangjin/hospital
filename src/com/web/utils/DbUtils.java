package com.web.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbUtils {

	public static void close(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
			}
		}
	}

	public final static void close(Statement stmt) {
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
			}
		}
	}

	public final static void close(ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
			}
		}
	}

	public static Boolean getBoolean(ResultSet rs, String columnName)
			throws SQLException {
		boolean val = rs.getBoolean(columnName);
		return rs.wasNull() ? Boolean.FALSE : Boolean.valueOf(val);
	}

	public static <T extends Number> void setNumber(PreparedStatement cstmt,
			int parameterIndex, T x) throws SQLException {
		if (x == null) {
			cstmt.setNull(parameterIndex, java.sql.Types.NUMERIC);
		} else if (x instanceof Double) {
			cstmt.setDouble(parameterIndex, x.doubleValue());
		} else if (x instanceof Long) {
			cstmt.setLong(parameterIndex, x.longValue());
		} else if (x instanceof Integer) {
			cstmt.setInt(parameterIndex, x.intValue());
		} else if (x instanceof Short) {
			cstmt.setShort(parameterIndex, x.shortValue());
		} else if (x instanceof Byte) {
			cstmt.setShort(parameterIndex, x.byteValue());
		} else {
			cstmt.setObject(parameterIndex, x);
		}
	}

}
