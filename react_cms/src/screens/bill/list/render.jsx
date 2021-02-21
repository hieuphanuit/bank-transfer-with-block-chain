import React from 'react';
import Button from '@material-ui/core/Button';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import TablePagination from '@material-ui/core/TablePagination';
import Paper from '@material-ui/core/Paper';
import { Breadcrumbs, Link, Typography } from '@material-ui/core';

import useStyles from "./styles";

const headers = [
  {
    "value": "Id",
    "field": "id",
    "align": "left"
  },
  {
    "value": "User id",
    "field": "user_id"
  },
  {
    "value": "Type",
    "field": "type_text",
    "align": "left"
  },
  {
    "value": "Amount",
    "field": "amount"
  },
  {
    "value": "Time",
    "field": "time"
  },
  {
    "value": "Action",
    "align": "center"
  }
]

const RenderPage = (props) => {
  const classes = useStyles();

  return (
    <div className={classes.root}>
      <Breadcrumbs aria-label="breadcrumb" className={classes.paper}>
          <Typography color="textPrimary">Bills</Typography>
      </Breadcrumbs>
      <Button
        variant="contained"
        onClick={() => props.handleAddMoreClick()}
        color="secondary"
        className={`${classes.button} ${classes.addButton}`}
      >
        Add more
      </Button>
      <Paper className={classes.paper}>
        <TableContainer component={Paper}>
          <Table className={classes.table}>
            <TableHead>
              <TableRow>
                {
                  headers.map((header, idx) =>
                    <TableCell
                      key={idx}
                      align={header.align ? header.align : "right"}
                    >
                      {header.value}
                    </TableCell>
                  )
                }
              </TableRow>
            </TableHead>

            <TableBody>
              {props.bills.map((row, rowIdx) => (
                <TableRow key={rowIdx}>
                  {headers.map((header, idx) =>
                    header.field && <TableCell
                      key={idx}
                      align={header.align ? header.align : "right"}
                    >
                      {row[header.field]}
                    </TableCell>
                  )}

                  <TableCell
                    align="center"
                  >
                    <Button
                      variant="outlined"
                      onClick={() => props.handleDetailClick(row['id'])}
                      color="primary"
                      className={classes.button}
                    >
                      Detail
                    </Button>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>

        <TablePagination
          rowsPerPageOptions={[5, 10, 20]}
          component="div"
          count={props.total}
          rowsPerPage={props.rowsPerPage}
          page={props.page}
          onChangePage={props.handleChangePage}
          onChangeRowsPerPage={props.handleChangeRowsPerPage}
        />
      </Paper>
    </div>
  )
}

export default RenderPage;