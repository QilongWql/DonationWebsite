// 数据库连接模块
const mysql = require('mysql2/promise');
require('dotenv').config();

// 数据库连接配置
const dbConfig = {
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || 'password',
  database: process.env.DB_NAME || 'charityevents_db'
};

// 创建连接池
const pool = mysql.createPool(dbConfig);

// 测试数据库连接
async function testConnection() {
  try {
    const connection = await pool.getConnection();
    console.log('数据库连接成功');
    connection.release();
    return true;
  } catch (error) {
    console.error('数据库连接失败:', error);
    return false;
  }
}

// 获取所有活动
async function getAllEvents() {
  try {
    const [rows] = await pool.query(`
      SELECT e.*, c.name as charity_name 
      FROM events e
      LEFT JOIN charities c ON e.charity_id = c.charity_id
      ORDER BY e.start_date ASC
    `);
    
    // 获取每个活动的类别
    for (let event of rows) {
      const [categories] = await pool.query(`
        SELECT c.category_id, c.name, c.description
        FROM categories c
        JOIN event_categories ec ON c.category_id = ec.category_id
        WHERE ec.event_id = ?
      `, [event.event_id]);
      
      event.categories = categories;
    }
    
    return rows;
  } catch (error) {
    console.error('获取活动列表失败:', error);
    throw error;
  }
}

// 获取单个活动详情
async function getEventById(eventId) {
  try {
    const [events] = await pool.query(`
      SELECT e.*, c.name as charity_name, c.description as charity_description, 
             c.logo_url, c.website, c.contact_email, c.contact_phone
      FROM events e
      LEFT JOIN charities c ON e.charity_id = c.charity_id
      WHERE e.event_id = ?
    `, [eventId]);
    
    if (events.length === 0) {
      return null;
    }
    
    const event = events[0];
    
    // 获取活动的类别
    const [categories] = await pool.query(`
      SELECT c.category_id, c.name, c.description
      FROM categories c
      JOIN event_categories ec ON c.category_id = ec.category_id
      WHERE ec.event_id = ?
    `, [eventId]);
    
    event.categories = categories;
    
    return event;
  } catch (error) {
    console.error('获取活动详情失败:', error);
    throw error;
  }
}

// 搜索活动
async function searchEvents(filters) {
  try {
    let query = `
      SELECT e.*, c.name as charity_name 
      FROM events e
      LEFT JOIN charities c ON e.charity_id = c.charity_id
    `;
    
    const queryParams = [];
    const conditions = [];
    
    // 添加日期过滤
    if (filters.startDate) {
      conditions.push('e.start_date >= ?');
      queryParams.push(filters.startDate);
    }
    
    if (filters.endDate) {
      conditions.push('e.end_date <= ?');
      queryParams.push(filters.endDate);
    }
    
    // 添加地点过滤
    if (filters.city) {
      conditions.push('e.city LIKE ?');
      queryParams.push(`%${filters.city}%`);
    }
    
    // 添加类别过滤
    if (filters.categoryId) {
      query += `
        JOIN event_categories ec ON e.event_id = ec.event_id
      `;
      conditions.push('ec.category_id = ?');
      queryParams.push(filters.categoryId);
    }
    
    // 组合WHERE子句
    if (conditions.length > 0) {
      query += ' WHERE ' + conditions.join(' AND ');
    }
    
    // 添加排序
    query += ' ORDER BY e.start_date ASC';
    
    const [rows] = await pool.query(query, queryParams);
    
    // 获取每个活动的类别
    for (let event of rows) {
      const [categories] = await pool.query(`
        SELECT c.category_id, c.name, c.description
        FROM categories c
        JOIN event_categories ec ON c.category_id = ec.category_id
        WHERE ec.event_id = ?
      `, [event.event_id]);
      
      event.categories = categories;
    }
    
    return rows;
  } catch (error) {
    console.error('搜索活动失败:', error);
    throw error;
  }
}

// 获取所有类别
async function getAllCategories() {
  try {
    const [rows] = await pool.query('SELECT * FROM categories');
    return rows;
  } catch (error) {
    console.error('获取类别列表失败:', error);
    throw error;
  }
}

module.exports = {
  testConnection,
  getAllEvents,
  getEventById,
  searchEvents,
  getAllCategories
};